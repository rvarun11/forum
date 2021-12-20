module Web.Controller.Events where

import Web.Controller.Prelude
import Web.View.Events.Index
import Web.View.Events.New
import Web.View.Events.Edit
import Web.View.Events.Show

instance Controller EventsController where
    beforeAction = ensureIsUser

    action EventsAction = do
        (eventsQ, pagination) <- query @Event |> paginate
        events <- eventsQ |> fetch
        render IndexView { .. }

    action NewEventAction = do
        let event = newRecord
        render NewView { .. }

    action ShowEventAction { eventId } = autoRefresh do
        event <- fetch eventId
            >>= fetchRelated #userId

        goingCount <- query @EventUser 
            |> filterWhere (#eventId, eventId)
            |> fetchCount

        isGoing <- query @EventUser
            |> filterWhere (#eventId, eventId)
            |> filterWhere (#userId, currentUserId)
            |> fetchExists
        
        render ShowView { .. }

    action EditEventAction { eventId } = do
        event <- fetch eventId
        render EditView { .. }

    action UpdateEventAction { eventId } = do
        event <- fetch eventId
        
        let title = param @Text "title"
        let body = param @Text "body"
        let startAt = param @UTCTime "startAt"
        let endAt = param @UTCTime "endAt"
        let loc = param @Point "loc"
        event <- event 
            |> set #title title
            |> set #body body
            |> set #startAt startAt
            |> set #endAt endAt 
            |> set #loc loc
            |> set #userId currentUserId
            |> updateRecord
        setSuccessMessage "Event updated"
        redirectTo EditEventAction { .. }

    action CreateEventAction = do
        let title = param @Text "title"
        let body = param @Text "body"
        let startAt = param @UTCTime "startAt"
        let endAt = param @UTCTime "endAt"
        let loc = param @Point "loc"

        let event = newRecord @Event
        putStrLn "Entered the action"
        event <- event
            |> set #title title
            |> set #body body
            |> set #startAt startAt
            |> set #endAt endAt 
            |> set #loc loc
            |> set #userId currentUserId
            |> createRecord

        let eventId = get #id event
            
        setSuccessMessage "Event created"
        redirectTo ShowEventAction { .. }
    
    action CreateEventUserAction { eventId } = do
        event <- fetch eventId
        let eventUser = newRecord @EventUser
        eventUser <- eventUser
            |> set #userId currentUserId
            |> set #eventId eventId
            |> createRecord
        setSuccessMessage "Marked as going"
        redirectTo ShowEventAction { .. }

    action DeleteEventUserAction { eventId } = do
        eventUser <- query @EventUser
            |> filterWhere (#eventId, eventId)
            |> fetchOne
        deleteRecord eventUser
        setSuccessMessage "Marked as not going"
        redirectTo ShowEventAction { .. }

    action DeleteEventAction { eventId } = do
        event <- fetch eventId
        deleteRecord event
        setSuccessMessage "Event deleted"
        redirectTo PostsAction

