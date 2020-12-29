module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Page as Page
import Page.Home as Home
import Page.Mods as Mods
import Page.NotFound as NotFound
import Url exposing (Url)


type alias Model =
    { key : Nav.Key
    , url : Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url, Cmd.none )


type Msg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ChangedUrl url ->
            ( { model | url = url }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    case model.url.path of
        "/" ->
            Page.view Page.Home Home.view

        "/home" ->
            Page.view Page.Home Home.view

        "/mods" ->
            Page.view Page.Mods Mods.view

        _ ->
            Page.view Page.Other (NotFound.view model.url)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
