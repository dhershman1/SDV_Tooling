port module Api exposing (post, storageDecoder, storageEncoder)

import Http exposing (Body)
import Json.Decode as D
import Json.Encode as E


type Msg
    = GotMods (Result Http.Error ModResponse)


type alias Mod =
    { id : String
    , updateKeys : List String
    , installedVersion : String
    , isBroken : Bool
    }


type alias ModResponse =
    { mods : List Mod
    , apiVersion : String
    , gameVersion : String
    , platform : String
    , includeExtendedMetadata : Bool
    }


port storeCache : Maybe D.Value -> Cmd msg


storageDecoder : D.Decoder (List String)
storageDecoder =
    D.list D.string


storageEncoder : List String -> Cmd msg
storageEncoder ids =
    let
        json =
            E.list E.string ids
    in
    storeCache (Just json)


port onStoreChange : (D.Value -> msg) -> Sub msg


modsDecoder : D.Decoder Mod
modsDecoder =
    D.map4 Mod
        (D.field "id" D.string)
        (D.field "updateKeys" (D.list D.string))
        (D.field "installedVersion" D.string)
        (D.field "isBroken" D.bool)


requestDecoder : D.Decoder ModResponse
requestDecoder =
    D.map5 ModResponse
        (D.field "mods" (D.list modsDecoder))
        (D.field "apiVersion" D.string)
        (D.field "gameVersion" D.string)
        (D.field "platform" D.string)
        (D.field "includeExtendedMetadata" D.bool)


post : String -> Body -> Cmd Msg
post url body =
    Http.request
        { method = "POST"
        , headers = []
        , url = url
        , body = body
        , expect = Http.expectJson GotMods requestDecoder
        , timeout = Nothing
        , tracker = Nothing
        }
