module Data.GradeLevel exposing (GradeLevel, GradeLevelId(..), decoder, listDecoder)

import Json.Decode as Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (optional, required)


type GradeLevelId
    = GradeLevelId Int


type alias GradeLevel =
    { id : GradeLevelId
    , code : String
    , description : String
    }



-- SERIALIZATION --


decoder : Decoder GradeLevel
decoder =
    Decode.succeed GradeLevel
        |> required "id" (int |> Decode.map GradeLevelId)
        |> required "code" string
        |> required "description" string


listDecoder : Decoder (List GradeLevel)
listDecoder =
    Decode.list decoder
