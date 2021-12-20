module Web.View.Events.Show where
import Web.View.Prelude

import Application.Helper.Users (isOwner)
import Application.Helper.View (renderMarkdown)

import qualified Text.MMark as MMark
import Data.Rope.UTF16 (toText)


data ShowView = ShowView { event :: Include "userId" Event, goingCount :: !Int, isGoing :: !Bool }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {navbar [("", ""), ("", "Show Event")]}

        <div class="card">
            <div class="card-body">
                <h2 class="card-title">{get #title event}
                <div style="float:right;text-align:right;">
                    <div class="d-inline-block border border-dark px-2 mr-1"> 
                        <span style="font-size:18px;font-weight:normal">Going&nbsp;</span>
                        <span style="font-size:30px;"> {goingCount} </span> </div>
                </div>
                </h2>
                <h6 class="card-subtitle mb-2 text-muted">{isOwner (get #userId event)}, {get #createdAt event |> timeAgo}</h6>


                <div class="card-text">
                    <p> From : {get #startAt event |> dateTime} </p>
                    <p> To : {get #endAt event |> dateTime} </p>
                    <p>{get #body event |> renderMarkdown} </p>
                    {attend}
                </div>
                
                <div id="map" data-loc={show $ get #loc event}></div>

                <div class="mt-2">{ownerActions}</div>
            </div>
        </div>

        <!-- TODO: Google Maps API Script goes here -->
    |]
        where
        ownerActions =
            if get #id (get #userId event) == currId then
            [hsx|<a href={EditEventAction (get #id event)}>Edit</a> 
                | <a class="js-delete" href={DeleteEventAction (get #id event)}>Delete</a>
            |]
            else 
                [hsx|
                |]
            where
                currId = get #id currentUser
        
        attend = 
            if isGoing then [hsx|
            <a class="js-delete btn btn-outline-primary js-delete-no-confirm mb-3" href={DeleteEventUserAction (get #id event)}>Mark as Not Going</a>             
            |]
            else [hsx|
            <form method="POST" action={CreateEventUserAction (get #id event)}>
                <button type="submit" class="btn btn-outline-primary mb-3">Mark as Going</button>
            </form>   
            |]

