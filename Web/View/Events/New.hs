module Web.View.Events.New where
import Web.View.Prelude

data NewView = NewView { event :: Event }

instance View NewView where
    html NewView { .. } = [hsx|
        {navbar [("", ""), ("", "New Event")]}
        <h1>New Event</h1>
    |]

