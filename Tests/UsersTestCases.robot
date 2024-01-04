*** Settings ***
Library               RequestsLibrary
Resource              ../Resources/Settings/global-variable.robot

*** Variables ***
${PATH_USERS}    ${BASE_URL}/users

*** Keywords ***

*** Test Cases ***

Get Users From Page 3
    ${response} =     GET    ${PATH_USERS}    params=page=3  expected_status=200
    Should Be Equal As Numbers   ${response.json()}[page]    3

Get Single User With Exist Id
    ${response} =     GET    ${PATH_USERS}/1    expected_status=200
    Should Be Equal As Numbers    ${response.json()}[data][id]    1

Get Single User With Id Isn't Exist
    ${response} =     GET    ${PATH_USERS}/100    expected_status=404

Get Single User With Id Valued With String
    ${response} =     GET    ${PATH_USERS}/asd    expected_status=404