module Main exposing (main)


import Browser
import Browser.Navigation as Nav
import Json.Decode as D
import Message exposing (AppMsg(..))
import Model exposing (AppFlags, AppModel, flagsDecoder, initialModel)
import Platform exposing (Program)
import Url exposing (Url)
import View exposing (render)


getTitle : AppModel -> String
getTitle model =
    "Playlist Health Check"


getView : AppModel -> Browser.Document msg
getView model =
    { title = getTitle model
    , body = [ render model ]
    }


appInit : D.Value -> Url -> Nav.Key -> (AppModel, Cmd AppMsg)
appInit json url key =
    let
        model = initialModel key
    in
        case D.decodeValue flagsDecoder json of
            Ok flags ->
                ({ model | flags = flags }, Cmd.none)
            Err err ->
                (Model.setAppError (D.errorToString err) model, Cmd.none)


main : Program D.Value AppModel AppMsg
main = Browser.application
    { init = appInit
    , onUrlChange = \url -> NoOp
    , onUrlRequest = \urlRequest -> NoOp
    , subscriptions = \_ -> Sub.none
    , update = \msg model -> (model, Cmd.none)
    , view = getView
    }