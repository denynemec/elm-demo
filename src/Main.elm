module Main exposing (..)

import Browser
import Html exposing (Attribute, Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


type alias Model =
    { response : RemoteDataRefetching }


init : flags -> ( Model, Cmd Msg )
init _ =
    ( { response = Loading }
    , fetchTodoItems []
    )


type RemoteDataRefetching
    = NotAsked
    | Loading
    | Failure Http.Error
    | Success TodoList
    | Refetching TodoList


type alias TodoList =
    List TodoItem


type alias TodoItem =
    { todoLabel : String
    , id : Int
    }


type Msg
    = ClickedRefetchTodos TodoList
    | GotTodoList TodoList RemoteDataRefetching


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedRefetchTodos todoList ->
            ( { model
                | response = Refetching todoList
              }
            , fetchTodoItems todoList
            )

        GotTodoList todoList response ->
            ( { model
                | response = response
              }
            , Cmd.none
            )


fetchTodoItems : TodoList -> Cmd Msg
fetchTodoItems todoList =
    Http.get
        { url = "https://jsonplaceholder.typicode.com/todos"
        , expect = Http.expectJson (fromResultToRemoteDataRefetching >> GotTodoList todoList) decodeTodoList
        }


fromResultToRemoteDataRefetching : Result Http.Error TodoList -> RemoteDataRefetching
fromResultToRemoteDataRefetching result =
    case result of
        Ok data ->
            Success data

        Err error ->
            Failure error


decodeTodoList : Decode.Decoder TodoList
decodeTodoList =
    Decode.list decodeTodoItem


decodeTodoItem : Decode.Decoder TodoItem
decodeTodoItem =
    Decode.succeed TodoItem
        |> Pipeline.required "title" Decode.string
        |> Pipeline.required "id" Decode.int


view : Model -> Html Msg
view model =
    Html.div centeredColumnAttributes
        [ todoListResponseView model.response
        ]


todoListResponseView : RemoteDataRefetching -> Html Msg
todoListResponseView response =
    case response of
        NotAsked ->
            Html.text "Klikni na cudlik"

        Loading ->
            Html.text "Loading ..."

        Success todoList ->
            List.map todoItemView todoList
                |> (::) (Html.button [ Events.onClick <| ClickedRefetchTodos todoList ] [ Html.text "Fetch todo items" ])
                |> Html.div []

        Refetching todoList ->
            List.map todoItemView todoList
                |> (::) (Html.text "Loading ...")
                |> Html.div []

        Failure _ ->
            Html.text "Error"


todoItemView : TodoItem -> Html Msg
todoItemView todoItem_ =
    let
        formattedTodoItemText =
            formatTodoItemText todoItem_
    in
    Html.div [] [ Html.text formattedTodoItemText ]


formatTodoItemText : TodoItem -> String
formatTodoItemText todoItem =
    String.fromInt todoItem.id ++ " - " ++ todoItem.todoLabel



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
