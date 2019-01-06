module Page.Components exposing 
    ( Component
    , Model
    , initModel
    , view
    , Msg
    , init
    , update
    )
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import PageLayout
import Json.Decode exposing (Decoder, field, string, int, float)

type alias Component = 
    { id: Int
    , name: String
    , description: String
    , price: Float
    }

type alias Model = {
        components: List Component
    }
initModel : Model
initModel = {
        components = []
    }

type alias HttpResult = Result Http.Error (List Component)
type Msg = GotComponents HttpResult

view : Model -> PageLayout.PageData Msg
view model =  
    { title = "Components Page"
    , content = [
        div [] 
            [ h1 [] [text "Components"]
            , if (List.isEmpty model.components) then
                div [class "cart-panel"] [ text "no component" ]
            else 
                viewComponents model.components
            ]
        ]
    }


update: Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        GotComponents (Ok components) -> ({model|components=components}, Cmd.none)
        GotComponents (Err httpErr) -> (model, Cmd.none)

init : () -> (Model, Cmd Msg)
init _ = (initModel, loadComponents)

loadComponents : Cmd Msg
loadComponents = Http.get
    { url = "/api/components"
    , expect = Http.expectJson GotComponents componentsDecoder
    }

componentDecoder : Decoder Component
componentDecoder = Json.Decode.map4 Component
    (field "id" int)
    (field "name" string)
    (field "description" string)
    (field "price" float)

componentsDecoder : Decoder (List Component)
componentsDecoder = Json.Decode.list componentDecoder

viewComponents : List Component -> Html Msg
viewComponents components = 
    table []
        [thead []
            [tr []
                [ th [] [text "id"]
                , th [] [text "name"]
                , th [] [text "description"]
                , th [] [text "price"]
                ]
            ]
        , tbody []
            (List.map 
                (\component -> 
                    tr []
                        [ td [] [text (String.fromInt component.id)]
                        , td [] [text component.name]
                        , td [] [text component.description]
                        , td [] [text (String.fromFloat component.price)]
                        ]
                )
                components
            )
        ]