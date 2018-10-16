module Data.Mission exposing (Mission, MissionId(..), decoder, listDecoder, slugParser)

import Data.Domain exposing (DomainId(..))
import Data.GradeLevel exposing (GradeLevelId(..))
import Json.Decode as Decode exposing (Decoder, bool, int, string)
import Json.Decode.Pipeline exposing (optional, required)
import Url.Parser as Parser exposing (Parser, custom)


type MissionId
    = MissionId Int


type alias Mission =
    { id : MissionId
    , gradeLevelId : GradeLevelId
    , domainId : DomainId
    , activeQuestCount : Int
    , inactiveQuestCount : Int
    , helpText : String
    , active : Bool
    }



-- SERIALIZATION --


decoder : Decoder Mission
decoder =
    Decode.succeed Mission
        |> required "id" (int |> Decode.map MissionId)
        |> required "grade_level_id" (int |> Decode.map GradeLevelId)
        |> required "domain_id" (int |> Decode.map DomainId)
        |> required "active_quest_count" int
        |> required "inactive_quest_count" int
        |> optional "help_text" string "no help text"
        |> required "active" bool


listDecoder : Decoder (List Mission)
listDecoder =
    Decode.list decoder



--


parseMissionId : String -> Int
parseMissionId id =
    String.toInt id |> Maybe.withDefault 0


slugParser : Parser (MissionId -> a) a
slugParser =
    custom "MISSION_ID" (\id -> Just (MissionId (parseMissionId id)))
