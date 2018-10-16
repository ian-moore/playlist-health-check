module Model exposing (..)


import Browser.Navigation as Nav
import Json.Decode as D
import Session exposing (Session(..))


type alias AppFlags =
    { debug : Bool
    }


flagsDecoder : D.Decoder AppFlags
flagsDecoder =
    D.map AppFlags
        (D.field "debug" D.bool)


type AppState
    = AppError
    | AppOk
    | AppLoading


type alias AppModel =
    { data : String
    , error : Maybe String
    , flags : AppFlags
    , session : Session
    , state : AppState
    }


setAppError : String -> AppModel -> AppModel
setAppError errorMsg model =
    { model
    | error = Just errorMsg
    , state = AppError
    }


initialModel : Nav.Key -> AppModel
initialModel key = 
    { data = "foo"
    , error = Nothing
    , flags = { debug = False }
    , session = Guest key
    , state = AppLoading
    }