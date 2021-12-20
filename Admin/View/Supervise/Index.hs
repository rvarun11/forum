module Admin.View.Supervise.Index where
import Web.View.Prelude
import Admin.Types
import Web.View.Prelude (User'(comments), ForumData (fdIsBlocked))


data IndexView = IndexView { forumData :: ![ForumData], postCount :: !Int, commentCount :: !Int, eventCount :: !Int }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {navbar [("", ""), ("/admin/", "Admin"), ("", "Supervise")]}
        <div class="p-3"> 
            <h1 class="d-inline-block align-bottom">Supervisor Panel</h1>
            <div style="float:right;text-align:right;">
                <div class="d-inline-block border border-dark px-2 mr-1"> Posts <span style="font-size:40px;"> {postCount} </span> </div>
                <div class="d-inline-block border border-dark px-2 mr-1"> Events <span style="font-size:40px;"> {eventCount} </span> </div>
                <div class="d-inline-block border border-dark px-2"> Comments <span style="font-size:40px;"> {commentCount} </span> </div>
            </div>
        </div>
        <div class="table-responsive pt-2">
            <table class="table">
                <thead>
                    <tr>
                        <th>Latest</th>
                        <th>Type</th>
                        <th>By</th>
                        <th>Created at</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>{forEach forumData renderForumData}</tbody>
            </table>
        </div>
    |]

renderForumData :: ForumData -> Html
renderForumData fd = case fdType fd of 
    0 -> [hsx|
        <tr>             
            <td><a href={ShowPostAction (fdPostId fd)}>{fdTitle fd}</a></td>
            <td>Post</td>
            <td>{fdUser fd}</td>
            <td>{fdCreatedAt fd |> timeAgo}</td>
            <td> {postButton (fdPostId fd) (fdIsBlocked fd)} </td>
        </tr>
    |]
    1 -> [hsx|
        <tr> 
            <td><a href={ShowPostAction (fdPostId fd)}>{fdTitle fd}</a></td>
            <td>Comment</td>
            <td>{fdUser fd}</td>
            <td>{fdCreatedAt fd |> timeAgo}</td>
            <td> {commentButton (fdCommentId fd) (fdIsBlocked fd)} </td>
        </tr>
    |]
    2 -> [hsx|
        <tr> 
            <td><a href={ShowEventAction (fdEventId fd)}>{fdTitle fd}</a></td>
            <td>Event</td>
            <td>{fdUser fd}</td>
            <td>{fdCreatedAt fd |> timeAgo}</td>
            <td> {eventButton (fdEventId fd) (fdIsBlocked fd)} </td>
        </tr>
    |]
    _ -> [hsx|
    |]

postButton postId isBlocked = if isBlocked then [hsx|
    <form method="POST" action={MarkPostAction postId}>
        <button  class="btn btn-outline-primary"> Unblock </button>
    </form>
    |]
else [hsx|
    <form method="POST" action={MarkPostAction postId}>
        <button type="submit" class="btn btn-outline-danger"> Block </button>   
    </form>
 
|]

commentButton commentId isBlocked = if isBlocked then [hsx|
    <form method="POST" action={MarkCommentAction commentId}>
     <button type="submit" class="btn btn-outline-primary"> Unblock </button>
    </form>

    |]
else [hsx|
    <form method="POST" action={MarkCommentAction commentId}>
        <button type="submit" class="btn btn-outline-danger"> Block </button>
    </form>

|]

eventButton eventId isBlocked = if isBlocked then [hsx|
    <form method="POST" action={MarkEventAction eventId}>
        <button type="submit"  class="btn btn-outline-primary"> Unblock </button>
    </form>

    |]
else [hsx|
    <form method="POST" action={MarkEventAction eventId}>
        <button type="submit" class="btn btn-outline-danger"> Block </button>
    </form>

|]