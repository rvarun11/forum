module Admin.View.Users.Edit where
import Admin.View.Prelude

data EditView = EditView { user :: User }

instance View EditView where
    html EditView { .. } = [hsx|
        {editUserHeader user}
        {renderForm user}
    |]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    <div class="form-group">
        <label for="username">Username</label>
        <p name="username" id="username" class="form-control">{get #email user}</p>
    </div>
    {(passwordField #passwordHash) { placeholder = "<leave blank to keep password unchanged>", fieldLabel = "Change Password" }}
    {adminFormFields user}
    {submitButton { label = "Save" }}

|]

adminFormFields :: _ => User -> Html
adminFormFields user = 
    if get #isAdmin currentUser then [hsx|
    {(textField #failedLoginAttempts) { helpText = "Use this to reset the number manually if desired."}}
    {(textField #isAdmin)}
    |]
    else [hsx|
    |]


editUserHeader :: _ => User -> Html
editUserHeader user =
    if get #isAdmin currentUser then [hsx|
    {navbar [("",""), ("/admin/", "Admin"), ("", "Users")]}
        <h2>Edit User</h2>
    |]
    else [hsx|
        {navbar [("",""), ("", "Settings")]}
        <h2>User Settings</h2>
    |]