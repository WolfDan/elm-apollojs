module Data.Comment exposing (Comment, decoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (decode, optional, required)
import Data.User as User exposing (User)


type alias Comment =
    { body : String
    , author : User
    }


decoder : Decoder Comment
decoder =
    decode Comment
        |> optional "body" Decode.string ""
        |> required "author" User.decoder
