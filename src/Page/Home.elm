module Page.Home exposing (view)

import Html exposing (Html, div, h1, img, main_, p, section, text)
import Html.Attributes exposing (alt, class, id, src, tabindex)


view : { title : String, content : Html msg }
view =
    { title = "Home"
    , content =
        main_ [ class "home" ]
            [ h1 [ class "center" ] [ text "About" ]
            , div [ class "card" ]
                [ section [ class "about__description" ]
                    [ p [] [ text "Welcome to SDV Tooling! This might be something one day!" ]
                    ]
                ]
            ]
    }
