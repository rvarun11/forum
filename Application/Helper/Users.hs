module Application.Helper.Users where

import Admin.Controller.Prelude
import Admin.Types
import Admin.Routes
import Web.Types
import Web.Routes

import IHP.ViewPrelude (hsx, Html)

newtype IsAdmin = IsAdmin Bool


-- TODO: add settings
userSignedIn :: _ => Html
userSignedIn = [hsx|
        <span style="float:right;text-align:right;">
            <div>Welcome {get #email currentUser}! <a class="js-delete js-delete-no-confirm" href={DeleteSessionAction}>Log out</a></div>
            <div><a href={pathTo $ Admin.Types.EditUserAction currentUserId}>Settings</a>{adminLink}</div>
        </span>
    |]
        where 
            adminLink = if isUserAdmin then [hsx|&nbsp| <a href="/admin/">Admin</a>|]
                        else [hsx||]

initUserAdminInfo :: _ => IO ()
initUserAdminInfo = 
    if isJust currentUserOrNothing then 
        do
            let isAdmin = get #isAdmin currentUser
            putContext $ IsAdmin isAdmin

    else 
        pure ()

isUserAdmin :: _ => Bool
isUserAdmin = case fromFrozenContext of
    IsAdmin isAdmin -> isAdmin

isOwner :: _ => User -> Html
isOwner pUser = 
    if pUser == currentUser then
        [hsx|You|]
    else [hsx|{get #email pUser}|]  