module View exposing (render)


import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Pages.SplashPage as SplashPage
import Session exposing (..)
import UI.ErrorWrapper exposing (errorWrapper)


renderHeader : AppModel -> Html msg
renderHeader model =
    div [ class "mainViewHeader-root" ]
        [ text "Playlist Health Check" ]


renderBody : AppModel -> Html msg
renderBody model =
    case model.session of
        Guest key ->
            SplashPage.render key
        Authenticated key user ->
            div [] [ text "Logged in!" ]


render : AppModel -> Html msg
render model =
    errorWrapper model.error
        [ div [ class "mainView-root" ] 
            [ renderHeader model 
            , renderBody model
            ]
        ]