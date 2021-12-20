module Web.View.Posts.New where
import Web.View.Prelude

import Web.View.Events.Edit (eventFormContent)

data NewView = NewView

instance View NewView where
    html NewView = [hsx|
        {navbar [("", ""), ("", "New Content")]}
        <h3>New Content</h3>
          <div class="form-group form-check">
            <input type="radio" name="r1" class="ms-3" checked id="event_radio" onclick="formToggle();" >&nbsp;Event&nbsp;&nbsp;
            <input type="radio" name="r1" id="post_radio" onclick="formToggle();" >&nbsp;Post
        </div>
        {renderPostForm}
        {renderEventForm}
    |]


renderPostForm :: Html
renderPostForm = [hsx|
    <form method="POST" action={CreatePostAction} id="create_post" style="display:none;">
        <div class="form-group">
            <label for="post_title">Title</label>
            <input type="text" name="title" id="post_title" class="form-control" required/>
        </div>
        <div class="form-group">
            <label for="post_body">Body</label>
            <input type="text" name="body" id="post_body" class="form-control"/>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
|]

renderEventForm :: Html
renderEventForm = [hsx|
    <form method="POST" action={CreateEventAction} id="create_event">
        {eventFormContent}
    </form>
|]

