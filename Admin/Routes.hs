module Admin.Routes where
import IHP.RouterPrelude
import Generated.Types
import Admin.Types

-- Generator seter
instance AutoRoute StaticController
instance AutoRoute UsersController
instance AutoRoute SuperviseController

