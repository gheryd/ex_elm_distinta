module Page.NotFound exposing (view)
import Html exposing (..)
import PageLayout


view : () -> PageLayout.PageData Never
view _ = 
    {
        title = "Page Not Found",
        content = [
            div [] [text "NotFound Page..."]
            ]
    }
    