module Page.Products exposing 
    ( Product
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

type alias Product = 
    { id: Int
    , name: String
    , description : String
    }

type alias Model = {
        products : List Product
    }
initModel : Model
initModel = {
        products = []
    }

view : Model -> PageLayout.PageData Msg
view model =  
    { title = "Products Page"
    , content = [
        div [] 
            [ h1 [] [text "Products"]
            , if (List.isEmpty model.products) then
                div [class "cart-panel"] [ text "no products" ]
            else 
                viewProducts model.products
            ]
        ]
    }

type alias HttpResult = Result Http.Error (List Product)

type Msg = 
    None
   | GotProducts HttpResult

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        GotProducts (Ok products) -> ({model|products=products}, Cmd.none)
        GotProducts (Err httpErr) -> (model, Cmd.none)
        None -> (model, Cmd.none)
--
init : () -> (Model, Cmd Msg)
init _ = (initModel, loadProducts)

loadProducts : Cmd Msg
loadProducts = Http.get 
    { url = "/api/products"
    , expect = Http.expectJson GotProducts productsDecoder
    }

productDecoder : Decoder Product
productDecoder = Json.Decode.map3 Product
    (field "id" int)
    (field "name" string)
    (field "description" string)

productsDecoder : Decoder (List Product)
productsDecoder = Json.Decode.list productDecoder 

viewProducts : List Product -> Html Msg
viewProducts products = 
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
                (\product -> 
                    tr []
                        [ td [] [text (String.fromInt product.id)]
                        , td [] [text product.name]
                        , td [] [text product.description]
                        ]
                )
                products
            )
        ]
    
