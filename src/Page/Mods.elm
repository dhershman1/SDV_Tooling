module Page.Mods exposing (view)

import Html exposing (Html, div, h1, img, main_, p, section, text)
import Html.Attributes exposing (alt, class, id, src, tabindex)


view : { title : String, content : Html msg }
view =
    { title = "Mods"
    , content =
        main_ [ class "mods" ]
            [ h1 [ class "center" ] [ text "About" ]
            , div [ class "card" ]
                [ section [ class "mods__description" ]
                    [ p [] [ text "Modding things can go here" ]
                    ]
                ]
            ]
    }
