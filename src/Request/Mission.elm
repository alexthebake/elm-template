module Request.Mission exposing (get)

import Data.Mission as Mission exposing (Mission)
import Http
import Request.Helpers exposing (apiUrl)


get : Http.Request (List Mission)
get =
    Http.get (apiUrl "missions") Mission.listDecoder
