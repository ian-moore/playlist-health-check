module Main exposing (main)


import Browser
import Html
import Platform exposing (Program)


type AppMsg
  = DumbMessage
  | NoOp


type alias AppModel =
  { data : String
  }


initialModel = { data = "foo" }


main : Program () AppModel AppMsg
main = Browser.document
  { init = \_ -> (initialModel, Cmd.none)
  , subscriptions = \_ -> Sub.none
  , update = \_ _ -> (initialModel, Cmd.none)
  , view = \_ -> { title = "elm title", body = [ Html.div [] [ Html.text "Hello from Elm!" ] ]}
  }