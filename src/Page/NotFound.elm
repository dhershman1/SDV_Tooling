module Page.NotFound exposing (view)

import Html exposing (Html, a, b, div, h1, main_, p, text)
import Html.Attributes exposing (class, href)
import Route
import Url exposing (Url)


view : Url -> { title : String, content : Html msg }
view url =
    { title = "404 Not Found"
    , content =
        main_ [ class "not-found" ]
            [ h1 [] [ text "404 Not Found" ]
            , b [] [ text url.path ]
            , div [ class "err__description" ]
                [ p [] [ text "Looks like that wasn't found friend!" ]
                , a [ Route.href Route.Home ] [ text "Go Home" ]
                ]
            ]
    }
