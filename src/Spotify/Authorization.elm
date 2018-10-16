module Spotify.Authorization exposing (implicitAuthUrl)


import Dict exposing (Dict)
import List
import Result
import String
import Url exposing (Url)
import Url.Builder as UrlBuilder
import Url.Parser as UrlParser exposing ((</>))


implicitAuthUrl : String -> String -> String
implicitAuthUrl clientId redirectUri = 
    UrlBuilder.crossOrigin
        "https://accounts.spotify.com"
        [ "authorize" ]
        [ UrlBuilder.string "clientid" clientId
        , UrlBuilder.string "response_type" "token"
        , UrlBuilder.string "redirect_uri" redirectUri
        , UrlBuilder.string "state" "TODO"
        , UrlBuilder.string "scope" "TODO: scopes we need"
        , UrlBuilder.string "show_dialog" "false"
        ]


type alias GrantedData =
    { accessToken : String
    , tokenType : String
    , expiresIn : Int
    , state : String
    }


type alias DeniedData =
    { error : String
    , state : String
    }


type Authorization
    = Denied DeniedData
    | Granted GrantedData


valuesToTuple : String -> Maybe (String, String)
valuesToTuple s =
    case String.split "=" s of
        [key, val] ->
            Just (key, val)
        _ ->
            Nothing

fragmentParams : String -> Dict String String
fragmentParams frag =
    String.split "&" frag
    |> List.filterMap valuesToTuple
    |> Dict.fromList


authGrantFromParams : Dict String String -> Result String GrantedData
authGrantFromParams params =
    let
        token = Dict.get "access_token" params
        tokenType = Dict.get "token_type" params
        expiresIn = Dict.get "expires_in" params
        state = Dict.get "state" params
    in
        case [token, tokenType, expiresIn, state] of
            [Just t1, Just t2, Just e, Just s] ->
                case String.toInt e of
                    Just x ->
                        Ok <| GrantedData t1 t2 x s
                    Nothing ->
                        Err "Expiration time is invalid."
            _ ->
                Err "Response fragment does not contain all required parameters."


fragmentAuthParser : Maybe String -> Result String Authorization
fragmentAuthParser fragment =
    case fragment of
        Just f ->
            case String.contains "auth_token" f of
                True ->
                    fragmentParams f 
                    |> authGrantFromParams 
                    |> Result.map Granted
                    |> Result.mapError (\s -> s ++ " Auth Response: " ++ f)
                False ->
                    Err "WTF"
        Nothing ->
            -- todo: parse denied query string via callbackParser oneOf
            Err "DENIED"


callbackParser : String -> UrlParser.Parser (Result String Authorization -> a) a
callbackParser callbackPath =
    UrlParser.s callbackPath </> UrlParser.fragment fragmentAuthParser


parseCallback : Url -> Result String Authorization
parseCallback url =
    Err "TODO"

