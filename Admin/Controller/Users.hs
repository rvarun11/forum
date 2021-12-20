module Admin.Controller.Users where

import Admin.Controller.Prelude
import Admin.View.Users.Index
import Admin.View.Users.New
import Admin.View.Users.Edit
import Admin.View.Users.Show

instance Controller UsersController where
    action UsersAction = do
        (usersQ, pagination) <- query @User 
            |> orderBy #email
            |> paginate
        users <- usersQ |> fetch
        render IndexView { .. }

    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    action ShowUserAction { userId } = do
        user <- fetch userId
        render ShowView { .. }

    action EditUserAction { userId } = do
        user <- fetch userId
        render EditView { .. }

    action UpdateUserAction { userId } = do
        user <- fetch userId
        user
            |> buildUser
            |> ifValid \case
                Left user -> render EditView { .. }
                Right user -> do
                    hashedPassword <- hashPassword (get #passwordHash user)
                    user <- user 
                        |> set #passwordHash hashedPassword
                        |> updateRecord
                    setSuccessMessage "User updated"
                    redirectTo EditUserAction { .. }

    action CreateUserAction = do
        let user = newRecord @User
        user
            |> buildUser
            |> ifValid \case
                Left user -> render NewView { .. } 
                Right user -> do
                    hashedPassword <- hashPassword (get #passwordHash user)
                    user <- user 
                        |> set #passwordHash hashedPassword
                        |> createRecord
                    setSuccessMessage "User created"
                    redirectTo UsersAction

    action DeleteUserAction { userId } = do
        user <- fetch userId
        deleteRecord user
        setSuccessMessage "User deleted"
        redirectTo UsersAction

buildUser user = user
    |> fill @["email","passwordHash","failedLoginAttempts","isAdmin"]
