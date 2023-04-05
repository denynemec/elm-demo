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
-- Increment logic
-- Add Decrement
-- Add ClickedFetchTodos
-- Add fetch "https://jsonplaceholder.typicode.com/todos"
---- MODEL ----


type alias Model =
    { counter : Int
    , todosResponse : TodosResponse
    }


init : ( Model, Cmd Msg )
init =
    ( { counter = 0
      , todosResponse = RemoteData.NotAsked
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = Increment
    | IncrementBy Int
    | ClickedFetchTodos
    | FetchedTodos TodosResponse


type alias TodosResponse =
    RemoteData.WebData (List TodoItem)


type alias TodoItem =
    { id : TodoItemId
    , title : String
    }


type alias TodoItemId =
    String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | counter = model.counter + 1 }
            , Cmd.none
            )

        IncrementBy incrementBy ->
            ( { model | counter = model.counter + incrementBy }
            , Cmd.none
            )

        ClickedFetchTodos ->
            ( { model | todosResponse = RemoteData.Loading }
            , fetchTodosCmd
            )

        FetchedTodos response ->
            ( { model | todosResponse = response }
            , Cmd.none
            )


fetchTodosCmd : Cmd Msg
fetchTodosCmd =
    { method = "GET"
    , headers = []
    , url = "https://jsonplaceholder.typicode.com/todos"
    , body = Http.emptyBody

    -- We always need to specify type. Elm need to know, what response we expect (JSON, string, bytes...) and need to know, what to do with it
    -- In this case, we expect JSON
    -- (RemoteData.fromResult >> FetchedTodos) - it will transform it - about it later
    -- ((Decode.list decodeTodoItem)) - decoder - "how to parse JSON into out data structure in Elm"
    , expect = Http.expectJson (RemoteData.fromResult >> FetchedTodos) (Decode.list decodeTodoItem)
    , timeout = Nothing
    , tracker = Nothing
    }
        |> Http.request


decodeTodoItem : Decode.Decoder TodoItem
decodeTodoItem =
    -- Pipeline.required needs to be in same order as properties in TodoItem recird type alias signature (id, title, ...)
    Decode.succeed TodoItem
        |> Pipeline.required "id" Decode.string
        |> Pipeline.required "title" Decode.string



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
        , Html.div [ Attributes.style "padding-top" "20px" ]
            [ Html.button
                [ Events.onClick (IncrementBy 7)
                , Attributes.style "width" "100px"
                ]
                [ Html.text "Increment by 7!" ]
            ]
        , Html.div [ Attributes.style "padding-top" "20px" ]
            [ Html.button
                [ Events.onClick (IncrementBy 100)
                , Attributes.style "width" "100px"
                ]
                [ Html.text "Increment by 100!" ]
            ]
        , Html.div [ Attributes.style "padding-top" "20px" ]
            [ Html.button
                [ Events.onClick ClickedFetchTodos
                , Attributes.style "width" "100px"
                ]
                [ Html.text "Fetch TODOS!" ]
            ]
        , Html.text <| "Current value: " ++ String.fromInt model.counter
        , todosResponseView model.todosResponse
        ]


todosResponseView : TodosResponse -> Html Msg
todosResponseView todosResponse =
    case todosResponse of
        RemoteData.NotAsked ->
            Html.text "Not asked..."

        RemoteData.Loading ->
            Html.text "Loading..."

        -- In this example, we ignore error (_) - we just display "Error!" text, but in Failure payload, we have access to whole error and we han show specific text for different error types - based on status code, decoder error (we expect different data), etc.
        RemoteData.Failure error ->
            let
                _ =
                    Debug.log "error" error
            in
            Html.text "Error!"

        RemoteData.Success todos ->
            Html.div centeredColumnAttributes <|
                List.map todoView todos



-- todoView : TodoItem -> Html Msg


todoView todoItem =
    Html.div [] [ Html.text "formattedTodoItemText" ]



-- formatTodoItemText : TodoItem -> String
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
