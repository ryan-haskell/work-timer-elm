module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import Page exposing (Page)
import WorkTask exposing (WorkTask)


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
    , workTasks : List WorkTask
    }


init : ( Model, Cmd Msg )
init =
    ( Model
        Page.TaskView
        []
    , Cmd.none
    )



-- UPDATE


type Msg
    = NavLinkClicked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ nav
            [ class "navbar light-shadow" ]
            [ div [ class "container" ]
                [ h3 [ class "nav-title flex" ]
                    [ text (getTitle model) ]
                , a [ class "nav-link", onClick NavLinkClicked ]
                    [ h3 [] [ i [ class (getIcon model) ] [] ]
                    ]
                ]
            ]
        , div
            [ class "container flex white-bg light-shadow" ]
            [ (viewPage model) ]
        ]


viewPage : Model -> Html Msg
viewPage model =
    div [] []


getTitle : Model -> String
getTitle model =
    case model.page of
        Page.TaskView ->
            "Task View"

        Page.NewTask ->
            "New Task"


getIcon : Model -> String
getIcon model =
    case model.page of
        Page.TaskView ->
            "fa fa-plus"

        Page.NewTask ->
            "fa fa-close"
