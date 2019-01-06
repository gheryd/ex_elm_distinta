module Main exposing (..)
import Url
import Browser.Navigation as Nav
import Browser
import PageLayout
import Url.Parser exposing (Parser, (</>), (<?>), int, map, oneOf, s, string)
import Url.Parser.Query as Query
import Page.Home
import Page.Products
import Page.NotFound

main : Program () Model Msg
main = Browser.application 
    {
        init = init
        ,view = view
        ,update = update
        ,subscriptions = subscriptions
        ,onUrlChange = UrlChanged
        ,onUrlRequest = LinkClicked
    }

type Msg 
    = UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest
    | ProductsMsg Page.Products.Msg
    | HomeMsg Page.Home.Msg

type Page 
    = Home Page.Home.Model
    | Products Page.Products.Model
    | NotFound

type alias Model = 
    { key: Nav.Key
    , page: Page
    }

view : Model -> Browser.Document Msg
view model =
    case model.page of
        Home homeModel-> 
            PageLayout.view HomeMsg (Page.Home.view homeModel )
        Products productsModel-> 
            PageLayout.view ProductsMsg (Page.Products.view productsModel) 
        NotFound ->
            PageLayout.view never (Page.NotFound.view ())


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        UrlChanged url -> getPage model url
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url -> (model, Nav.pushUrl model.key (Url.toString url) )
                Browser.External href -> (model, Nav.load href)
        ProductsMsg productsMsg -> 
            case model.page of
                Products productsModel -> stepProducts model (Page.Products.update productsMsg productsModel)
                _ -> (model, Cmd.none)
        HomeMsg homeMsg -> 
            case model.page of
                Home homeModel -> stepHome model (Page.Home.update homeMsg homeModel)
                _ -> (model, Cmd.none)
        

init : () -> Url.Url -> Nav.Key -> (Model, Cmd Msg)
init flags url key = (
        Model key (Home {}), 
        Cmd.none
    )

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

getRoute : Model -> Parser ((Model, Cmd Msg) -> a) a
getRoute model =
    oneOf   
        [ map
            (stepHome model (Page.Home.init ()))
            Url.Parser.top
        , map 
            (stepProducts model (Page.Products.init ()))  
            (s "products" )
        ]

getPage : Model -> Url.Url -> (Model, Cmd Msg)
getPage model url = 
    case Url.Parser.parse (getRoute model) url of
        Just answer -> answer
        Nothing -> ({model|page=NotFound}, Cmd.none)

stepHome: Model -> (Page.Home.Model, Cmd Page.Home.Msg) -> (Model, Cmd Msg)
stepHome model (homeModel, homeMsg) =
    ( {model | page = Home homeModel}
    ,  Cmd.map HomeMsg homeMsg
    )

stepProducts: Model -> (Page.Products.Model, Cmd Page.Products.Msg) -> (Model, Cmd Msg)
stepProducts model (productsModel, productsMsg) =
    ( {model | page = Products productsModel}
    ,  Cmd.map ProductsMsg productsMsg
    )
    