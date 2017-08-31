port module Ports exposing (..)

import Json.Decode exposing (Value)


port queryUserAndSubReddit : ( String, String ) -> Cmd msg


port setUser : (Value -> msg) -> Sub msg


port setNewListing : (Value -> msg) -> Sub msg
