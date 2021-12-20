module Admin.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data AdminApplication = AdminApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)

data SuperviseController 
    = SuperviseAction
    | MarkPostAction { postId :: !(Id Post) }
    | MarkCommentAction { commentId :: !(Id Comment) }
    | MarkEventAction { eventId :: !(Id Event) }

    deriving (Eq, Show, Data)
