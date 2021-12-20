module Admin.FrontController where

import IHP.RouterPrelude
import Admin.Controller.Prelude
import Admin.View.Layout (defaultLayout)

-- Controller Imports
import Admin.Controller.Supervise
import Admin.Controller.Users
import Admin.Controller.Static

import IHP.LoginSupport.Middleware
import Web.Controller.Sessions

import Application.Helper.Users

instance FrontController AdminApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator seter
        , parseRoute @UsersController
        , parseRoute @SuperviseController
        ]

instance InitControllerContext AdminApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
        initAuthentication @User

        initUserAdminInfo

