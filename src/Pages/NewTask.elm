module Pages.NewTask exposing (viewForm)

import Message exposing (..)
import WorkTask exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


viewForm : WorkTask -> Html Msg
viewForm task =
    let
        inputs =
            [ ( task.name
              , "Name"
              , FormNameUpdated
              )
            , ( task.description
              , "Description"
              , FormDescriptionUpdated
              )
            ]
    in
        (div [ class "new-task-form form" ]
            ((List.map viewFormInput inputs)
                ++ [ div [ class "form-btn-group" ]
                        [ button
                            [ class "form-submit-btn form-btn"
                            , onClick AddNewTask
                            ]
                            [ text "Add Task" ]
                        , button
                            [ class "form-cancel-btn form-btn"
                            , onClick NavHomeClicked
                            ]
                            [ text "Cancel" ]
                        ]
                   ]
            )
        )


viewFormInput : ( String, String, String -> Msg ) -> Html Msg
viewFormInput ( value', label, msg ) =
    (div
        [ class "form-group" ]
        [ div [ class "form-label" ] [ text label ]
        , input [ type' "text", class "form-input", onInput msg, value value' ]
            []
        ]
    )
