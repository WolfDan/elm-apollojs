module Data.Listing exposing (Listing, decoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (decode, optional)
import Data.Comment as Comment exposing (Comment)


type alias Listing =
    { title : String
    , comments : List Comment
    }


decoder : Decoder Listing
decoder =
    decode Listing
        |> optional "title" Decode.string ""
        |> optional "comments" (Decode.list Comment.decoder) []
