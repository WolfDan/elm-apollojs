module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src, href)
import Html.Events exposing (..)
import Ports
import Data.User as User exposing (User)
import Data.Listings as Listings exposing (Listings)
import Json.Decode exposing (int, string, nullable, list, Decoder, decodeValue, Value)


-- MODEL


type alias Model =
    { counter : Int
    , user : User
    , listings : Listings
    , err : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { counter = 0
      , user =
            { username = ""
            , commentKarma = 0
            , createdISO = ""
            }
      , listings =
            { listings = []
            }
      , err = Nothing
      }
    , Cmd.none
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Sub.map SetUser userUpdate
        , Sub.map SetListing listingsUpdate
        ]


userUpdate : Sub (Result String User)
userUpdate =
    Ports.setUser (decodeValue User.decoder)


listingsUpdate : Sub (Result String Listings)
listingsUpdate =
    Ports.setNewListing (decodeValue Listings.decoder)



-- UPDATE


type Msg
    = Inc
    | SetUser (Result String User)
    | SetListing (Result String Listings)
    | Query


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Inc ->
            { model | counter = model.counter + 1 } ! []

        SetUser (Ok newuser) ->
            ( { model | user = newuser }, Cmd.none )

        SetUser (Err err) ->
            { model | err = Just err }
                ! []

        SetListing (Ok newlistings) ->
            ( { model | listings = newlistings }, Cmd.none )

        SetListing (Err err) ->
            { model | err = Just err } ! []

        Query ->
            ( model, Ports.queryUserAndSubReddit ( "kn0thing", "movies" ) )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 []
            [ img [ src "images/logo.png" ] []
            , text "Hot loading"
            ]
        , p [] [ text "Click on the button below to increment the state." ]
        , div []
            [ button
                [ class "btn btn-primary"
                , onClick Inc
                ]
                [ text "+ 1" ]
            , text <| toString model.counter
            ]
        , div []
            [ button
                [ class "btn btn-primary"
                , onClick Query
                ]
                [ text "Query Graphql!" ]
            , text <| toString model.user ++ toString model.listings
            ]
        , p [] [ text "Then make a change to the source code and see how the state is retained after you recompile." ]
        , p []
            [ text "And now don't forget to add a star to the Github repo "
            , a [ href "https://github.com/simonh1000/elm-webpack-starter" ] [ text "elm-webpack-starter" ]
            ]
        ]
