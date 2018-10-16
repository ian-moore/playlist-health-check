module Session exposing (User, Session(..))


import Browser.Navigation as Nav


type alias User =
    { userid : String }


type Session
    = Guest Nav.Key
    | Authenticated Nav.Key User