module Request.GradeLevel exposing (get)

import Data.GradeLevel as GradeLevel exposing (GradeLevel)
import Http
import Request.Helpers exposing (apiUrl)


get : Http.Request (List GradeLevel)
get =
    Http.get (apiUrl "grade_levels") GradeLevel.listDecoder
