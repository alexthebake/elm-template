module Pages.Pages exposing (Model, init)

import Pages.Mission.List as MissionsListPage


type Model
    = MissionsListPage.Model


init : Model
init = MissionsListPage.init
