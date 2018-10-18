module View exposing (view)

import Model exposing (Model)
import Browser
import Update exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import HttpBuilder exposing (..)
import Route exposing (Route(..))
import Data.Domain as Domain exposing (Domain)
import Data.DomainId as DomainId exposing (DomainId(..))
import Data.GradeLevel as GradeLevel exposing (GradeLevel)
import Data.GradeLevelId as GradeLevelId exposing (GradeLevelId(..))
import Data.Mission as Mission exposing (Mission)
import Data.MissionId as MissionId exposing (MissionId(..))
import RemoteData exposing (WebData)
import Update exposing (..)

-- fix?
import Page.Curriculum.Main as CurriculumPage


-- Inside View.elm, we define the view for our model and set up any event handlers we need.

view : Model -> Browser.Document Msg
view model =
    { title = "Test App"
    , body = renderRoute model
    }

renderRoute : Model -> List (Html Msg)
renderRoute model =
    case model.route of
        Just CurriculumRoute ->
            [ CurriculumPage.view model
            ]

        Just (MissionRoute missionId) ->
            [ renderMission model missionId ]

        Nothing ->
            [ h2 [] [ text "Error!, no route found" ] ]

renderMission : Model -> MissionId -> Html Msg
renderMission model missionId =
    let
        findMission missions =
            missions
                |> List.filter (\m -> m.id == missionId)
                |> List.head
    in
    case model.missions of
        RemoteData.NotAsked ->
            text "YOU FAIL"

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Failure err ->
            text (Debug.toString err)

        RemoteData.Success missions ->
            case findMission missions of
                Just mission ->
                    div []
                        [ div []
                            [ h1 []
                                [ text "Mission" ]
                            , p []
                                [ text <| "mission_id: " ++ MissionId.toString mission.id ]
                            , p []
                                [ text <| "help_text: " ++ mission.helpText ]
                            , p []
                                [ text <| "active: " ++ Debug.toString mission.active ]
                            ]
                        , Html.form [ onSubmit SubmitMissionUpdateForm ]
                            [ input [ name "id", type_ "hidden", value <| MissionId.toString mission.id ]
                                []
                            , textarea [ name "help_text", onInput SetMissionUpdateFormHelpText ]
                                [ text mission.helpText ]
                            , input [ name "active", type_ "checkbox", value "true", checked mission.active, onCheck SetMissionUpdateFormActive ]
                                []
                            , button [] [ text "submit" ]
                            ]
                        ]

                Nothing ->
                    div [] [ text "Mission missing!" ]