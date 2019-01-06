module PageLayout exposing (view, PageData)
import Html exposing (..)
import Html.Attributes exposing (..)
import Browser exposing (Document)


type alias PageData msg = 
    { title: String
    , content: List (Html msg)
    }

view : (a->msg) -> PageData a -> Document msg
view toMsg pageData = 
    { title = pageData.title
    , body = 
        [ viewHeader
        , Html.map toMsg 
            (div [] pageData.content)
        ,viewFooter
        ]
    }

-- private
viewHeader : Html msg
viewHeader = 
    nav []
        [ div [class "nav-wrapper"]
            [ span [class "brand-logo"] [text "Distinta"]
            , ul [class "right hide-on-med-and-down"]
                [li []
                    [a [href "/"] [text "home"]
                    ]
                ]
            ]
        ]

viewFooter : Html msg
viewFooter = 
    footer [class "page-footer"] 
        [div [class "footer-copyright"]
            [div [class "container"] 
                [text "footer"]
            ]
        ]