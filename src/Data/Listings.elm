module Data.Listings exposing (Listings, decoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (decode, required)
import Data.Listing as Listing exposing (Listing)


type alias Listings =
    { listings : List Listing }


decoder : Decoder Listings
decoder =
    decode Listings
        |> required "newListings" (Decode.list Listing.decoder)
