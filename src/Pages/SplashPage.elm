module Pages.SplashPage exposing (render)


import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)

render : Nav.Key -> Html msg
render key =
    div [ class "splashPage-root" ]
        [ text "Sign in to get playlist health" ]
  