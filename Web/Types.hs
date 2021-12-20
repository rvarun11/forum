module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

import IHP.LoginSupport.Types
import Data.Hourglass (UTC)
import qualified IHP.QueryBuilder as QueryBuilder


data WebApplication = WebApplication deriving (Eq, Show)

data StaticController 
    = WelcomeAction
    | RegisterAction
    | CreateUserAction
    deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

type instance CurrentUserRecord = User

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

data PostsController
    = PostsAction
    | NewContentAction
    | ShowPostAction { postId :: !(Id Post) }
    | CreatePostAction
    | EditPostAction { postId :: !(Id Post) }
    | UpdatePostAction { postId :: !(Id Post) }
    | DeletePostAction { postId :: !(Id Post) }
    deriving (Eq, Show, Data)

data CommentsController
    = CommentsAction
    | NewCommentAction { postId :: !(Id Post) }
    | ShowCommentAction { commentId :: !(Id Comment) }
    | CreateCommentAction
    | EditCommentAction { commentId :: !(Id Comment) }
    | UpdateCommentAction { commentId :: !(Id Comment) }
    | DeleteCommentAction { commentId :: !(Id Comment) }
    deriving (Eq, Show, Data)

data ForumData = ForumData 
    { fdType :: !Int
    , fdTitle :: !Text
    , fdPostId :: Id Post
    , fdEventId :: Id Event
    , fdCommentId :: Id Comment
    , fdUser :: !Text
    , fdCreatedAt :: !UTCTime
    , fdIsBlocked :: !Bool
    }

data EventsController
    = EventsAction
    | NewEventAction
    | ShowEventAction { eventId :: !(Id Event) }
    | CreateEventAction
    | EditEventAction { eventId :: !(Id Event) }
    | UpdateEventAction { eventId :: !(Id Event) }
    | DeleteEventAction { eventId :: !(Id Event) }
    | CreateEventUserAction { eventId :: !(Id Event) }
    | DeleteEventUserAction { eventId :: !(Id Event) }
    deriving (Eq, Show, Data)
