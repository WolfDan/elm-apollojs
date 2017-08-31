module Data.User exposing (User, decoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (decode, optional)


type alias User =
    { username : String
    , commentKarma : Int
    , createdISO : String
    }


decoder : Decoder User
decoder =
    decode User
        |> optional "username" Decode.string ":D"
        |> optional "commentKarma" Decode.int 0
        |> optional "createdISO" Decode.string ""
