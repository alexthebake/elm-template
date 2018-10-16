module Pages.Mission.List exposing (Model, init, view)

import Data.Mission exposing (Mission)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { missions : List Mission
    }


init : Model
init =
    { missions = [] }


view : Model -> Html msg
view model =
    div
        []
        (List.map (\mission -> p [] [ text mission.helpText ]) model.missions)
