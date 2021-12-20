module Web.View.Posts.Show where
import Web.View.Prelude

import Application.Helper.Users (isOwner)


data ShowView = ShowView { post :: Include "userId" Post, comments :: [Include "userId" Comment] }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {navbar [("", ""), ("", "Show Post")]}

        <div class="card w-100 mt-3">
            <div class="card-body">
                <h2 class="card-title">{get #title post}</h2>
                <h6 class="card-subtitle mb-2 text-muted">{isOwner (get #userId post)}, {get #createdAt post |> timeAgo}</h6>
                <p class="card-text">{get #body post |> renderMarkdown}</p>
                <div>{ownerActions} </div>
            </div>
        </div>

        <div>{forEach comments renderComment}</div>
        <a class="btn btn-outline-primary ml-3" href={NewCommentAction (get #id post)}>Add Comment</a>
  
    |]
        where 
            ownerActions =
                if get #id (get #userId post) == currId then
                [hsx|<a href={EditPostAction (get #id post)}>Edit</a> 
                    | <a class="js-delete" href={DeletePostAction (get #id post)}>Delete</a>
                |]
                else 
                    [hsx|
                    |]
                where
                    currId = get #id currentUser

renderComment comment = [hsx|
            <div class="card m-3 w-50">
                <div class="card-body" style="background-color:#EFF0F0">
                    <h6 class="card-subtitle mb-2 text-muted">{isOwner (get #userId comment)}, {get #createdAt comment |> timeAgo}</h6>
                    <p class="card-text">{commentBody}</p>
                </div>
            </div>
    |]
    where
        user = get #userId comment
        commentBody = if get #isBlocked comment then [hsx|
            <b> This comment has been blocked by the admin. </b>
        |]
        else [hsx|
            {get #body comment}
        |]
