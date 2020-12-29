module Page exposing (Page(..), view)

import Browser exposing (Document)
import Html exposing (Html, a, div, footer, li, nav, p, text, ul)
import Html.Attributes exposing (class, classList, href)
import Route exposing (Route)


type Page
    = Other
    | Home
    | Mods


view : Page -> { title : String, content : Html msg } -> Document msg
view page { title, content } =
    { title = title ++ " - SDV Tooling"
    , body = [ div [ class "wrapper" ] [ viewHeader page, content, viewFooter ] ]
    }


isActive : Page -> Route -> Bool
isActive page route =
    case ( page, route ) of
        ( Home, Route.Home ) ->
            True

        ( Mods, Route.Mods ) ->
            True

        _ ->
            False


navbarLink : Page -> Route -> List (Html msg) -> Html msg
navbarLink page route linkContent =
    li [ class "navbar__item" ]
        [ a [ classList [ ( "navbar__link", True ), ( "navbar__link--active", isActive page route ) ], Route.href route ] linkContent ]


viewHeader : Page -> Html msg
viewHeader page =
    nav [ class "navbar" ]
        [ div [ class "navbar__container" ]
            [ a [ class "navbar__brand", Route.href Route.Home ]
                [ text "SDV Tooling" ]
            , ul [ class "navbar__nav" ] <|
                navbarLink page Route.Home [ text "Home" ]
                    :: viewMenu page
            ]
        ]


viewMenu : Page -> List (Html msg)
viewMenu page =
    let
        linkTo =
            navbarLink page
    in
    [ linkTo Route.Mods [ text "Mods" ]
    ]


viewFooter : Html msg
viewFooter =
    footer []
        [ p [] [ text "Copyright 2020 Dustin Hershman" ] ]
