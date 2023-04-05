module Main exposing (..)

import Browser
import Html exposing (Attribute, Html)
import Html.Attributes as Attributes
import Html.Events as Events



-- import Http
-- import Json.Decode as Decode
-- import Json.Decode.Pipeline as Pipeline
-- import RemoteData
-- TODO:
-- Increment logic
-- Add Decrement
-- Add ClickedFetchTodos
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
            ( model
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    Html.div centeredColumnAttributes
        [ Html.h1 [] [ Html.text "Example Elm app!" ]
        , Html.div [ Attributes.style "padding-top" "20px" ]
            [ Html.button
                [ Events.onClick Increment
                , Attributes.style "width" "100px"
                ]
                [ Html.text "Increment!" ]
            ]
        , Html.text <| "Current value: " ++ String.fromInt model
        ]



-- todoView : TodoItem -> Html Msg


todoView todoItem =
    let
        formattedTodoItemText =
            formatTodoItemText todoItem
    in
    Html.div [] [ Html.text formattedTodoItemText ]



-- formatTodoItemText : TodoItem -> String


formatTodoItemText todoItem =
    String.fromInt todoItem.id ++ " - " ++ todoItem.title



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



-- fetchTodosCmd : Cmd Msg
-- fetchTodosCmd =
--     { method = "GET"
--     , headers = []
--     , url = "https://jsonplaceholder.typicode.com/todos"
--     , body = Http.emptyBody
--     -- We always need to specify type. Elm need to know, what response we expect (JSON, string, bytes...) and need to know, what to do with it
--     -- In this case, we expect JSON
--     -- (RemoteData.fromResult >> FetchedTodos) - it will transform it - about it later
--     -- ((Decode.list decodeTodoItem)) - decoder - "how to parse JSON into out data structure in Elm"
--     , expect = Http.expectJson (RemoteData.fromResult >> FetchedTodos) (Decode.list decodeTodoItem)
--     , timeout = Nothing
--     , tracker = Nothing
--     }
--         |> Http.request
-- decodeTodoItem : Decode.Decoder TodoItem
-- decodeTodoItem =
--     -- Pipeline.required needs to be in same order as properties in TodoItem recird type alias signature (id, title, ...)
--     Decode.succeed TodoItem
--         |> Pipeline.required "id" Decode.int
--         |> Pipeline.required "title" Decode.string
