module Page.Components exposing (..)
import Html exposing (..)

type Msg = None

type alias Model = {}
initModel : Model
initModel = {}

view : Model -> Html Msg
view _ = 
    div [] [text "Todo Components"]