module Web.View.Posts.Index where
import Web.View.Prelude

data IndexView = IndexView { forumData :: [ForumData], pagination :: Pagination }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {navbar [("", "")]}
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-6">
                    <h1>Home<a href={pathTo NewContentAction} class="btn btn-primary ml-4">+ New</a></h1>
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
                        <th>Updates</th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody>{forEach forumData renderContent}</tbody>
            </table>
            {renderPagination pagination}
        </div>
    |]

renderContent :: ForumData -> Html
renderContent fd = case fdType fd of
    0 -> [hsx|
        <tr>
            <td> {fdUser fd} created a post titled <a href={ShowPostAction $ fdPostId fd}>{fdTitle fd}</a> - {fdCreatedAt fd |> timeAgo} </td>
        </tr>
    |]
    2 -> [hsx|
        <tr>
            <td> {fdUser fd} created an event <a href={ShowEventAction $ fdEventId fd}>{fdTitle fd}</a> - {fdCreatedAt fd |> timeAgo} </td>
        </tr>
        |]
    _ -> [hsx|
    
    |]