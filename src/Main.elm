module Main exposing (Model)

import Browser
import Browser.Navigation as Nav
import Data.Domain exposing (Domain)
import Data.GradeLevel exposing (GradeLevel)
import Data.Mission exposing (Mission)
import Data.Resource exposing (ResourceError, ResourceState)
import Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Pages.Pages as Pages
import Request.Domain
import Request.GradeLevel
import Request.Mission
import Url


type alias Model =
    { missions : ResourceState (List Mission)
    , domains : ResourceState (List Domain)
    , gradeLevels : ResourceState (List GradeLevel)
    , page : Pages.Model
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | ChangedUrl Url.Url
    | LoadMissions (Result Http.Error (List Mission))
    | LoadDomains (Result Http.Error (List Domain))
    | LoadGradeLevels (Result Http.Error (List GradeLevel))


initModel : Model
initModel =
    { missions = NotLoaded
    , domains = NotLoaded
    , gradeLevels = NotLoaded
    , page = Pages.init
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        loadMissions : Cmd Msg
        loadMissions =
            Http.send LoadMissions Request.Mission.get

        loadDomains : Cmd Msg
        loadDomains =
            Http.send LoadDomains Request.Domain.get

        loadGradeLevels : Cmd Msg
        loadGradeLevels =
            Http.send LoadGradeLevels Request.GradeLevel.get
    in
    ( initModel
    , Cmd.batch [ loadMissions, loadDomains, loadGradeLevels ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadMissions result ->
            case result of
                Ok missions ->
                    ( { model | missions = Loaded missions }
                    , Cmd.none
                    )

                Err err ->
                    ( { model | missions = Error (ResourceError err) }
                    , Cmd.none
                    )

        LoadDomains result ->
            case result of
                Ok domains ->
                    ( { model | domains = Loaded domains }
                    , Cmd.none
                    )

                Err err ->
                    ( { model | domains = Error (ResourceError err) }
                    , Cmd.none
                    )

        LoadGradeLevels result ->
            case result of
                Ok gradeLevels ->
                    ( { model | gradeLevels = Loaded gradeLevels }
                    , Cmd.none
                    )

                Err err ->
                    ( { model | gradeLevels = Error (ResourceError err) }
                    , Cmd.none
                    )

        _ ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    let
        missionsList : Html Msg
        missionsList =
            case model.missions of
                Loaded missions ->
                    div
                        []
                        (List.map (\m -> p [] [ text m.helpText ]) missions)

                _ ->
                    div [] [ text "Missions not loaded..." ]
    in
    { title = "Test App"
    , body = [ missionsList ]
    }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
-- changeRouteTo maybeRoute model =
--     case maybeRoute of
--         MissionList ->
--         MissionDetail missionId ->
-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = LinkClicked
        }
