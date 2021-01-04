module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Http
import Page as Page
import Page.Home as Home
import Page.Mods as Mods
import Page.NotFound as NotFound
import Url exposing (Url)


type alias Model =
    { key : Nav.Key
    , url : Url
    , response : String
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url "Loading", Cmd.none )


type Msg
    = ChangedUrl Url
    | GotMods (Result Http.Error String)
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

        GotMods results ->
            case results of
                Ok _ ->
                    ( { model | response = "MODS GOT" }, Cmd.none )

                Err _ ->
                    ( { model | response = "ERROR GETTING MODS" }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    case model.url.path of
        "/" ->
            Page.view Page.Home (Home.view model.response)

        "/home" ->
            Page.view Page.Home (Home.view model.response)

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
