module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome
import Web.View.Static.Register

instance Controller StaticController where
    action WelcomeAction = render WelcomeView
    action RegisterAction = render RegisterView

    action CreateUserAction = do
    let user = newRecord @User
    user
        |> buildUser
        |> ifValid \case
            Left user -> render RegisterView
            Right user -> do
                hashed <- hashPassword (get #passwordHash user)
                user <- user
                    |> set #passwordHash hashed
                    |> createRecord
                redirectTo PostsAction



buildUser user = user
    |> fill @["email", "passwordHash"]
    |> validateField #email nonEmpty
    |> validateField #passwordHash nonEmpty