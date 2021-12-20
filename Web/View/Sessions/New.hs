module Web.View.Sessions.New where
import Web.View.Prelude
import IHP.AuthSupport.View.Sessions.New

instance View (NewView User) where
    html NewView { .. } = [hsx|
        <style>
            /* body {
                background-image: url("/ihp-welcome-icon.svg");
                background-repeat: no-repeat;
                background-size: 1000px;
            } */
        </style>

        <div class="h-100 w-100" id="sessions-new">
            <div class="d-flex align-items-center">
                <div class="w-100">
                    <div style="max-width: 400px" class="mx-auto mb-5">
                        <h5 class="text-center">Welcome to macForum. Login to continue</h5>
                        <img src="rdr_logo.svg" width="400" style="margin-bottom:5px;"/>
                        {renderForm user}
                    </div>
                </div>
            </div>
        </div>
    |]

renderForm :: User -> Html
renderForm user = [hsx|
    <form method="POST" action={CreateSessionAction}>
        <div class="form-group">
            <input name="email" value={get #email user} type="text" class="form-control" placeholder="Username" required="required" autofocus="autofocus" />
        </div>
        <div class="form-group">
            <input name="password" type="password" class="form-control" placeholder="Password"/>
        </div>
        <button type="submit" class="btn btn-primary btn-block mb-2">Log In</button>
    </form>
    <a href={RegisterAction} class="btn btn-success btn-block"><span class="text-light"> Sign Up </span></a>
|]