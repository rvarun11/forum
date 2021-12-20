module Admin.Controller.Supervise where

import Application.Helper.Controller
import Web.Controller.Prelude

import Admin.View.Supervise.Index


import Admin.Types

instance Controller SuperviseController  where
    beforeAction =
        ensureIsUser
    action SuperviseAction = autoRefresh do
        posts <- query @Post 
            |> fetch
            >>= collectionFetchRelated #userId

        events <- query @Event
            |> fetch
            >>= collectionFetchRelated #userId
        
        comments <- query @Comment 
            |> fetch
            >>= collectionFetchRelated #postId
            >>= collectionFetchRelated #userId


        let fd = map makeForumPost posts ++ map makeForumComment comments ++ map makeForumEvent events
        
        let forumData = sortByCreatedAt fd
        let postCount = length posts
        let commentCount = length comments
        let eventCount = length events

        render IndexView { .. }

    action MarkPostAction { postId } = do
        post <- fetch postId
        let bool = not (get #isBlocked post)
        post
            |> set #isBlocked bool
            |> updateRecord
        redirectTo SuperviseAction 
    
    action MarkCommentAction { commentId } = do
        comment <- fetch commentId
        let bool = not (get #isBlocked comment)
        comment
            |> set #isBlocked bool
            |> updateRecord
        redirectTo SuperviseAction 

    action MarkEventAction { eventId } = do
        event <- fetch eventId
        let bool = not (get #isBlocked event)
        event
            |> set #isBlocked bool
            |> updateRecord
        redirectTo SuperviseAction 


