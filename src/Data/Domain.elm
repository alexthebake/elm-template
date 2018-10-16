module Data.Domain exposing (Domain, DomainId(..), decoder, listDecoder)

import Json.Decode as Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (optional, required)


type DomainId
    = DomainId Int


type alias Domain =
    { id : DomainId
    , code : String
    , description : String
    }



-- SERIALIZATION --


decoder : Decoder Domain
decoder =
    Decode.succeed Domain
        |> required "id" (int |> Decode.map DomainId)
        |> required "code" string
        |> required "description" string


listDecoder : Decoder (List Domain)
listDecoder =
    Decode.list decoder
