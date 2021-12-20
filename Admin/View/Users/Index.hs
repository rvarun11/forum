module Admin.View.Users.Index where
import Admin.View.Prelude

data IndexView = IndexView { users :: [ User ], pagination :: Pagination }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {navbar [("",""), ("/admin/", "Admin"), ("", "Users")]}

        <div class="container">
            <div class="row justify-content-between">
                <div class="col-6">
                    <h1>Users<a href={pathTo NewUserAction} class="btn btn-primary ml-4">+ New</a></h1>
                </div>
                <div class="col-5">
                    {renderFilter "Search"}
                </div>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>User</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach users renderUser}</tbody>
            </table>
            {renderPagination pagination}
        </div>
    |]

renderUser :: User -> Html
renderUser user = [hsx|
    <tr>
        <td>{get #email user}</td>
        <td><a href={EditUserAction (get #id user)} class="text-muted">Edit</a></td>
        <td><a href={DeleteUserAction (get #id user)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]