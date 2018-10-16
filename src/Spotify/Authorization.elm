module Spotify.Authorization exposing (implicitAuthUrl)


import Dict exposing (Dict)
import List
import String
import Tuple
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


buildAuthGrant : Dict String String -> GrantedData
buildAuthGrant =
    Dict.foldr
        (\k v data ->
            case k of
                "auth_token" ->
                    { data | accessToken = v }
                _ ->
                    data)
        { accessToken = ""
        , tokenType = ""
        , expiresIn = 0
        , state = ""
        }



fragmentAuthParser : Maybe String -> Result Authorization String
fragmentAuthParser fragment =
    case fragment of
        Just f ->
            case String.contains "auth_token" f of
                True ->
                    fragmentParams f
                    |> buildAuthGrant
                    |> Granted
                False ->
                    Err "WTF"
        Nothing ->
            -- todo: parse denied query string
            Err "DENIED"


callbackParser : String -> UrlParser.Parser (Result Authorization String -> a) a
callbackParser callbackPath =
    UrlParser.s callbackPath </> UrlParser.fragment fragmentAuthParser


parseCallback : Url -> Result Authorization String 
parseCallback url =
    Err "TODO"

