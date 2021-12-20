module Application.Helper.View where

import IHP.ViewPrelude

import Application.Helper.Users
import Web.Types (PostsController(PostsAction))

import qualified Text.MMark as MMark


-- Here you can add functions which are available in all your views
navbar :: _ => [(Text, Text)] -> Html
navbar breadItems = [hsx|
        <nav class="navbar justify-content-between" style="border-radius:0.5em">
            <!-- <a class="navbar-brand" href="#">
                <img src="/Sigma.png" alt="" width="30">
            </a> -->
            <ol class="breadcrumb bg-light mb-0">
                {forEach breadItems oneBreadcrumb}
            </ol>
            {userSignedIn}
        </nav>
    |]
        where
            oneBreadcrumb ("", "") = [hsx|<li class="breadcrumb-item active"><a href={PostsAction}> macForum</a></li>|]
            oneBreadcrumb ("", name) = [hsx|<li class="breadcrumb-item active">{name}</li>|]
            oneBreadcrumb (action, name) = [hsx|<li class="breadcrumb-item active"><a href={action}>{name}</a></li>|]

(>.>) :: (a -> b) -> (b -> c) -> (a -> c)
(>.>) f g =
    g . f


renderMarkdown text =
    case text |> MMark.parse "" of
        Left error -> "Something went wrong"
        Right markdown -> MMark.render markdown |> tshow |> preEscapedToHtml