module Main exposing (main)


import Browser
import Json.Decode as D
import Message exposing (AppMsg(..))
import Model exposing (AppFlags, AppModel, flagsDecoder, initialModel)
import Platform exposing (Program)
import View exposing (render)


getTitle : AppModel -> String
getTitle model =
    "Playlist Health Check"


getView : AppModel -> Browser.Document msg
getView model =
    { title = getTitle model
    , body = [ render model ]
    }


appInit : D.Value -> (AppModel, Cmd AppMsg)
appInit json =
    case D.decodeValue flagsDecoder (Debug.log "json" json) of
        Ok flags ->
            ({initialModel | flags = (Debug.log "flags" flags) }, Cmd.none)
        Err err ->
            let
                -- TODO: app error state / messages
                x = Debug.log "error" err
            in
                (initialModel, Cmd.none)


main : Program D.Value AppModel AppMsg
main = Browser.document
    { init = appInit
    , subscriptions = \_ -> Sub.none
    , update = \_ _ -> (initialModel, Cmd.none)
    , view = getView
    }