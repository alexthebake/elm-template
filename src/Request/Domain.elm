module Request.Domain exposing (get)

import Data.Domain as Domain exposing (Domain)
import Http
import Request.Helpers exposing (apiUrl)


get : Http.Request (List Domain)
get =
    Http.get (apiUrl "domains") Domain.listDecoder
