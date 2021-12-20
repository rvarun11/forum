module Web.View.Static.Register where
import Web.View.Prelude

data RegisterView = RegisterView

instance View RegisterView where
    html RegisterView = [hsx|
        <div class="h-100" id="sessions-new">
            <div class="d-flex align-items-center">
                <div class="w-100 justify-content-center">
                    <div style="max-width: 400px" class="mx-auto mb-5">
                        <img src="rdr_logo.svg" width="400" style="margin-bottom:5px;"/>
                        <h5 class="text-center">Sign Up to macForum</h5>
                        {renderForm}
                    </div>
                </div>
            </div>
        </div>
    |]

renderForm :: Html
renderForm = [hsx|
    <form method="POST" action={CreateUserAction}>
        <div class="form-group">
            <input name="email" type="text" class="form-control" placeholder="Username" required="required" autofocus="autofocus" />
        </div>
        <div class="form-group">
            <input name="password_hash" type="password" class="form-control" placeholder="Password"/>
        </div>
        <button type="submit" class="btn btn-success btn-block"><span class="text-light"> Sign Up </span></button>
        <a href={PostsAction} class="btn btn-light btn-block"><i class="fas fa-arrow-left text-primary">&nbsp;</i><span class="text-primary"> Back to Login </span> </a>

    </form>    
|]