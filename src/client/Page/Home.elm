module Page.Home exposing (view, Model, Msg, init, update)
import Html exposing (..)
import Html.Attributes exposing (..)
import PageLayout

type Msg = None
type alias Model = {}

init : () -> (Model, Cmd Msg)
init _ = ({}, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

view : Model -> PageLayout.PageData Msg
view model = 
    { title = "Home Page"
    , content = [
        div [class "collection"]
            [ a [class "collection-item", href "/products"] [text "products"]
            , a [class "collection-item", href "/components"] [text "components"]
            , a [class "collection-item", href "/categories"] [text "categories"]
            ]
        ]
    }
    