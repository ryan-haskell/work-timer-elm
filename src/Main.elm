module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import Message exposing (Msg(..))
import Page exposing (Page)
import WorkTask exposing (WorkTask)
import Pages.TaskView as TaskView
import Pages.NewTask as NewTask


-- MAIN


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { page : Page
    , tasks : List WorkTask
    , newTask : WorkTask
    }


init : ( Model, Cmd Msg )
init =
    ( Model
        Page.TaskView
        []
        (WorkTask
            ""
            ""
        )
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        newTask =
            model.newTask
    in
        case msg of
            NavActionClicked ->
                ( handleNavActionClicked model
                , Cmd.none
                )

            NavHomeClicked ->
                ( { model | page = Page.TaskView }
                , Cmd.none
                )

            FormNameUpdated newName ->
                ( { model | newTask = { newTask | name = newName } }
                , Cmd.none
                )

            FormDescriptionUpdated newDescription ->
                ( { model | newTask = { newTask | description = newDescription } }
                , Cmd.none
                )

            AddNewTask ->
                ( addNewTask model, Cmd.none )


getPage : Model -> Page
getPage model =
    case model.page of
        Page.TaskView ->
            Page.NewTask

        _ ->
            Page.TaskView


handleNavActionClicked : Model -> Model
handleNavActionClicked model =
    let
        newTask =
            if model.page == Page.NewTask then
                WorkTask "" ""
            else
                model.newTask
    in
        { model
            | page = getPage model
            , newTask = newTask
        }


addNewTask : Model -> Model
addNewTask model =
    let
        newTasks =
            model.tasks ++ [ model.newTask ]
    in
        { model
            | tasks = newTasks
            , newTask = WorkTask "" ""
            , page = Page.TaskView
        }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ nav
            [ class "navbar light-shadow" ]
            [ div [ class "container" ]
                [ a [ class "nav-link", onClick NavHomeClicked ]
                    [ h3 [] [ i [ class "fa fa-clock-o" ] [] ]
                    ]
                , h3 [ class "nav-title flex" ] [ text (getNavbarTitle model) ]
                , a [ class "nav-link", onClick NavActionClicked ]
                    [ h3 [] [ i [ class (getNavbarIcon model) ] [] ]
                    ]
                ]
            ]
        , div
            [ class "container flex white-bg light-shadow" ]
            [ (viewPage model) ]
        ]


viewPage : Model -> Html Msg
viewPage model =
    case model.page of
        Page.TaskView ->
            div [ class "task-view page" ]
                [ TaskView.viewTasks model.tasks ]

        Page.NewTask ->
            div [ class "new-task page" ]
                [ NewTask.viewForm model.newTask ]


getNavbarTitle : Model -> String
getNavbarTitle model =
    case model.page of
        Page.TaskView ->
            "Your Tasks"

        Page.NewTask ->
            "New Task"


getNavbarIcon : Model -> String
getNavbarIcon model =
    case model.page of
        Page.TaskView ->
            "fa fa-plus"

        Page.NewTask ->
            "fa fa-close"
