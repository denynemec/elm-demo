module Main exposing (..)

import Browser
import Html exposing (Attribute, Html)
import Html.Attributes as Attributes



-- import Http
-- import Json.Decode as Decode
-- import Json.Decode.Pipeline as Pipeline
-- import RemoteData
-- ------------------------------------------
-- ------------------------------------------
-- ------------------------------------------
-- TO PRESENT
-- List.map … |> List.map … |> List.filter …
-- When to use NoOp MSG?
-- Type ()
-- Never type?
-- The Never type is a type that doesn't have any values.
-- It's a type that can be specified in a type annotation, but you can't construct a Never value because it is valueless.
-- identity & always
-- ELM debugger
-- ------------------------------------------
-- ------------------------------------------
-- ------------------------------------------
-- TODO:
-- Add ClickedFetchTodos
-- Add fetch "https://jsonplaceholder.typicode.com/todos"


type alias Model =
    ()


init : flags -> ( Model, Cmd Msg )
init _ =
    ( ()
    , Cmd.none
    )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update NoOp model =
    ( model
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    Html.div centeredColumnAttributes [ Html.h1 [] [ Html.text "Example Elm app!" ] ]



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


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = init
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
