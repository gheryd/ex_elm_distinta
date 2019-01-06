module Page.Categories exposing 
    ( Category
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
import Json.Decode exposing (Decoder, field, string, int)
import PageLayout

type alias Category = 
    { id: Int
    , name: String
    , description : String
    }

type alias Model = {
        categories : List Category
    }
initModel : Model
initModel = {
        categories = []
    }

type alias HttpResult = Result Http.Error (List Category)
type Msg = GotCategories HttpResult

view : Model -> PageLayout.PageData Msg
view model =  
    { title = "Categories Page"
    , content = [
        div [] 
            [ h1 [] [text "Categories"]
            , if (List.isEmpty model.categories) then
                div [class "cart-panel"] [ text "no categories" ]
            else 
                viewCategories model.categories
            ]
        ]
    }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        GotCategories (Ok categories) -> ({model|categories=categories}, Cmd.none)
        GotCategories (Err httpErr) -> (model, Cmd.none)
--
init : () -> (Model, Cmd Msg)
init _ = (initModel, loadProducts)

loadProducts : Cmd Msg
loadProducts = Http.get 
    { url = "/api/categories"
    , expect = Http.expectJson GotCategories categoriesDecoder
    }

categoryDecoder : Decoder Category
categoryDecoder = Json.Decode.map3 Category
    (field "id" int)
    (field "name" string)
    (field "description" string)

categoriesDecoder : Decoder (List Category)
categoriesDecoder = Json.Decode.list categoryDecoder 

viewCategories : List Category -> Html Msg
viewCategories categories = 
    table []
        [thead []
            [tr []
                [ th [] [text "id"]
                , th [] [text "name"]
                , th [] [text "description"]
                ]
            ]
        , tbody []
            (List.map 
                (\category -> 
                    tr []
                        [ td [] [text (String.fromInt category.id)]
                        , td [] [text category.name]
                        , td [] [text category.description]
                        ]
                )
                categories
            )
        ]
    
