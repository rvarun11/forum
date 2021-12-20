module Web.View.Events.Edit where
import Web.View.Prelude

data EditView = EditView { event :: Event }

instance View EditView where
    html EditView { .. } = [hsx|
        {navbar [("", ""), ("", "Edit Event")]}
        <h1>Edit Event</h1>
        <form method="POST" action={UpdateEventAction (get #id event)} id="create_event">
            {eventFormContent}
        </form>
    |]

eventFormContent :: Html 
eventFormContent = [hsx|
        <div class="form-group">
            <label for="post_title">Title</label>
            <input type="text" name="title" id="post_title" class="form-control" required/>
        </div>
        <div class="form-group">
            <label for="post_body">Body</label>
            <input type="text" name="body" id="post_body" class="form-control" required/>
        </div>
        <div class="form-group">
            <label for="startAt">Start</label>
            <input type="datetime-local" name="startAt" class="form-control" id="startAt" required/>
        </div>
        <div class="form-group">
            <label for="endAt">End</label>
            <input type="datetime-local" name="endAt" id="endAt" required/>
        </div>
        <div class="form-group">
            <select style="width:100%;" name="loc" class="custom-select mt-2 mb-3">
                <option value="43.262534,-79.918075" id="post-select"> McMaster University Student Center </option>
                <option value="43.24473002498662,-79.86524047720862" id="event-select"> Sam Lawrence Park </option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
|]