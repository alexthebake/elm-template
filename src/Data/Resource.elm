module Data.Resource exposing (ResourceState(..), ResourceError(..))

type ResourceState a
    = NotLoaded
    | Loading
    | Loaded a
    | Error ResourceError


type ResourceError
    = ResourceError Http.Error