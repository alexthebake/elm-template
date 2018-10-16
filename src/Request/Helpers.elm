module Request.Helpers exposing (apiUrl)

apiUrl : String -> String
apiUrl endpoint
    = "http://localhost:3000/" ++ endpoint
