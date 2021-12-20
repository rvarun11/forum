module Web.View.Comments.New where
import Web.View.Prelude

data NewView = NewView { comment :: Comment, post :: Post }

instance View NewView where
    html NewView { .. } = [hsx|
        {navbar [("", ""), (pathTo $ ShowPostAction postId , postTitle), ("", "New Comment")]}
        <h3>New Comment for <q>{get #title post}</q></h3>
        {renderForm comment}
    |]
     where
        postId = get #id post
        postTitle = get #title post


renderForm :: Comment -> Html
renderForm comment = formFor comment [hsx|
    {(hiddenField #postId)}
    {(hiddenField #userId)}
    {(textField #body) {fieldLabel = "Comment"} }
    {submitButton}

|]