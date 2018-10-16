module Route exposing (Route(..), fromUrl, parser)

import Data.Mission as Mission exposing (MissionId)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s)


type Route
    = MissionList
    | MissionDetail MissionId


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map MissionList (s "")
        , Parser.map MissionDetail (s "mission" </> Mission.slugParser)
        ]


fromUrl : Url -> Maybe Route
fromUrl url =
    { url
        | path = Maybe.withDefault "" url.fragment
        , fragment = Nothing
    }
        |> Parser.parse parser
