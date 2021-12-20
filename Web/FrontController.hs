module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Events
import Web.Controller.Comments
import Web.Controller.Posts
import Web.Controller.Static


import IHP.LoginSupport.Middleware
import Web.Controller.Sessions

import Application.Helper.Users (initUserAdminInfo)

instance FrontController WebApplication where
    controllers = 
        [ startPage PostsAction
        , parseRoute @StaticController
        , parseRoute @SessionsController
        -- Generator Marker
        , parseRoute @EventsController
        , parseRoute @CommentsController
        , parseRoute @PostsController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
        initAuthentication @User

        initUserAdminInfo


