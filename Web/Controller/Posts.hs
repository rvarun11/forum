module Web.Controller.Posts where

import Web.Controller.Prelude
import Web.View.Posts.Index
import Web.View.Posts.New
import Web.View.Posts.Edit
import Web.View.Posts.Show

import qualified Text.MMark as MMark


instance Controller PostsController where
    beforeAction = ensureIsUser

    action PostsAction = autoRefresh do
        let name = get #email currentUser

        (postsQ, pagination) <- query @Post 
            |> filterWhere (#isBlocked, False)
            |> orderByDesc #createdAt 
            |> paginate
        
        (eventsQ, pagination) <- query @Event
            |> filterWhere (#isBlocked, False)
            |> orderByDesc #createdAt 
            |> paginate
        
        posts <- postsQ |> fetch
            >>= collectionFetchRelated #userId

        events <- eventsQ |> fetch
            >>= collectionFetchRelated #userId

        let fd = map makeForumPost posts ++ map makeForumEvent events
        let forumData = sortByCreatedAt fd

        render IndexView { .. }

    -- making it into a generalized actionx
    action NewContentAction = do
        render NewView

    action ShowPostAction { postId } = do
        post <- fetch postId
            >>= fetchRelated #userId

        comments <- query @Comment 
            |> filterWhere (#postId, postId)
            |> fetch
            >>= collectionFetchRelated #userId

        render ShowView { .. }

    action EditPostAction { postId } = do
        post <- fetch postId
        render EditView { .. }

    action UpdatePostAction { postId } = do
        post <- fetch postId
        post
            |> buildPost
            |> ifValid \case
                Left post -> render EditView { .. }
                Right post -> do
                    post <- post |> updateRecord
                    setSuccessMessage "Post updated"
                    redirectTo ShowPostAction { .. }

    action CreatePostAction = do
        let post = newRecord @Post
        post
            |> buildPost
            |> ifValid \case
                Left post -> do
                    render NewView
                Right post -> do
                    post <- post 
                        |> set #userId currentUserId 
                        |> createRecord
                    setSuccessMessage "Post created"
                    redirectTo PostsAction

    action DeletePostAction { postId } = do
        post <- fetch postId
        deleteRecord post
        setSuccessMessage "Post deleted"
        redirectTo PostsAction

buildPost post = post
    |> fill @["title","body"]
    |> validateField #title nonEmpty
    |> validateField #body nonEmpty
    |> validateField #body isMarkdown

isMarkdown :: Text -> ValidatorResult
isMarkdown text =
    case MMark.parse "" text of
        Left _ -> Failure "Please provide valid Markdown"
        Right _ -> Success

