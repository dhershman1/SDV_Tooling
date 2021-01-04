module Page.Home exposing (Msg, view)

import Html exposing (Html, button, div, h1, img, main_, p, section, text)
import Html.Attributes exposing (alt, class, id, src, tabindex)
import Html.Events exposing (onClick)
import Http


type Msg
    = GotMods (Result Http.Error String)


type Model
    = Failure
    | Loading
    | Success String


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.post { url = "https://smapi.io/api/v3.0/mods", body = {}, expect = Http.expectJson }
    )


view : String -> { title : String, content : Html msg }
view status =
    { title = "Home"
    , content =
        main_ [ class "home" ]
            [ h1 [ class "center" ] [ text "About" ]
            , div [ class "card" ]
                [ section [ class "about__description" ]
                    [ p [] [ text "Welcome to SDV Tooling! This might be something one day!" ]
                    , p [] [ text status ]
                    , button [] [ text "Fetch Mods" ]
                    ]
                ]
            ]
    }
