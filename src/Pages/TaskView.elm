module Pages.TaskView exposing (viewTasks)

import Message exposing (Msg(..))
import WorkTask exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


viewTasks : List WorkTask -> Html Msg
viewTasks tasks =
    if List.isEmpty tasks then
        h3 [ class "message flex" ] [ text "No tasks... Hooray?" ]
    else
        div [ class "tasks" ] (List.map viewTask tasks)


viewTask : WorkTask -> Html Msg
viewTask task =
    div [ class "task-card" ]
        [ h2 [ class "task-name" ] [ text task.name ]
        , p [ class "task-details" ] [ text (task.description) ]
        ]
