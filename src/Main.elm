module Main exposing (..)

import Browser
import Html exposing (Attribute, Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline
import RemoteData



-- TODO:
-- Add Decrement
-- Add Reset
-- Add fetch "https://jsonplaceholder.typicode.com/todos"
---- MODEL ----


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = Increment


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        counterValueString =
            String.fromInt model
    in
    Html.div centeredColumnAttributes
        [ Html.h1 [] [ Html.text "Example Elm app!" ]
        , Html.div [ Attributes.style "padding-top" "20px" ]
            [ Html.button
                [ Events.onClick Increment
                , Attributes.style "width" "100px"
                ]
                [ Html.text "Increment!" ]
            ]
        , Html.text <| "Current value: " ++ counterValueString
        ]



-- Html.text (String.fromInt todoItem.id ++ " - " ++ todoItem.title)


centeredColumnAttributes : List (Attribute Msg)
centeredColumnAttributes =
    [ Attributes.style "flex-direction" "column"
    , Attributes.style "display" "flex"
    , Attributes.style "align-items" "center"
    ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
