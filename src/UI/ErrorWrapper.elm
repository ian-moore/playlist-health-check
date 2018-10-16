module UI.ErrorWrapper exposing (errorWrapper)


import Html exposing (..)
import Html.Attributes exposing (..)


errorWrapper : Maybe String -> List (Html msg) -> Html msg
errorWrapper error children =
    case error of
        Just message ->
            div [ class "errorWrapper-root" ] 
                [ p [ class "errorWrapper-text" ]
                    [ text message ]
                ]
        Nothing ->
            div [ class "errorWrapper-passThrough" ] children