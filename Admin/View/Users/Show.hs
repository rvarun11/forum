module Admin.View.Users.Show where
import Admin.View.Prelude

data ShowView = ShowView { user :: User }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show User</h1>
        <p>{user}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Users" UsersAction
                            , breadcrumbText "Show User"
                            ]