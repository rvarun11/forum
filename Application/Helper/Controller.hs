module Application.Helper.Controller where

import IHP.ControllerPrelude
import Web.Types
import Generated.Types
import qualified IHP.QueryBuilder as QueryBuilder

-- Here you can add functions which are available in all your controllers


makeForumPost :: Include "userId" Post -> ForumData
makeForumPost post = ForumData 
    { fdType = 0
    , fdTitle = get #title post
    , fdPostId = get #id post
    , fdEventId = ""
    , fdCommentId = ""
    , fdUser = get #email (get #userId post)
    , fdCreatedAt = get #createdAt post
    , fdIsBlocked = get #isBlocked post
    }


makeForumComment :: Include "userId" (Include "postId" Comment) -> ForumData
makeForumComment comment = ForumData 
    { fdType = 1
    , fdTitle = get #body comment
    , fdPostId = get #id (get #postId comment)
    , fdEventId = ""
    , fdCommentId = get #id comment
    , fdUser = get #email (get #userId comment)
    , fdCreatedAt = get #createdAt comment
    , fdIsBlocked = get #isBlocked comment
    }


makeForumEvent :: Include "userId" Event -> ForumData
makeForumEvent event = ForumData 
    { fdType = 2
    , fdTitle = get #title event
    , fdPostId = ""
    , fdEventId = get #id event
    , fdCommentId = ""
    , fdUser = get #email (get #userId event)
    , fdCreatedAt = get #createdAt event
    , fdIsBlocked = get #isBlocked event
    }

sortByCreatedAt :: [ForumData] -> [ForumData]
sortByCreatedAt = sortOn (Down . fdCreatedAt)