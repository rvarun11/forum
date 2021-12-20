module Admin.View.Static.Welcome where
import Admin.View.Prelude
import Web.View.Prelude


import Admin.Controller.Supervise


data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
    {navbar [("",""), ("", "Admin")]}
    <h1>Admin Panel</h1>

    <div class="row">
        <div class="col-3">
            <div class="card" style="width:100%;">
            <div class="card-body">
                <h5 class="card-title">Users</h5>
                <p class="card-text">Edit the users in the groups to which you belong.</p>
                <a href={pathTo UsersAction} class="btn btn-primary">Manage Users</a>
            </div>
            </div>
        </div>
        <div class="col-3">
            <div class="card" style="width:100%;">
            <div class="card-body">
                <h5 class="card-title">Supervision</h5>
                <p class="card-text">Supervise the posts and comments activity.</p>
                <a href={pathTo SuperviseAction} class="btn btn-primary">Supervise</a>
            </div>
            </div>
        </div>
    </div>
|]