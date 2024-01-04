*** Settings ***
Library               RequestsLibrary
Resource              ../Resources/Settings/global-variable.robot

*** Variables ***
${PATH_REGISTER}    ${BASE_URL}/register



*** Keywords ***

*** Test Cases ***

Register With Valid Data
    ${body}    Create Dictionary    email=eve.holt@reqres.in    password=Pistol_123
    ${response} =     POST    url=${PATH_REGISTER}    json=${body}    expected_status=200

Register Without Password
    ${body}    Create Dictionary    email=sydney@fife
    ${response} =     POST    url=${PATH_REGISTER}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[error]    Missing password

Register Without @ Symbol On Email Field
    ${body}    Create Dictionary    email=bruvexample.org    password=Pistol_123
    ${response} =     POST    url=${PATH_REGISTER}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[error]    Format didn't meet requirement

Register With Valid Email And Password Less Than 8 Character
    ${body}    Create Dictionary    email=eve.holt@reqres.in    password=Secr_12
    ${response} =     POST    url=${PATH_REGISTER}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[error]    Format didn't meet requirement

Register With Valid Email And Password Without Symbol
    ${body}    Create Dictionary    email=eve.holt@reqres.in    password=Secret123
    ${response} =     POST    url=${PATH_REGISTER}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[error]    Format didn't meet requirement

Register With Valid Email And Password Without Number
    ${body}    Create Dictionary    email=eve.holt@reqres.in    password=Secret_secret
    ${response} =     POST    url=${PATH_REGISTER}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[error]    Format didn't meet requirement

Register With Valid Email And Password Without Uppercase Letter
    ${body}    Create Dictionary    email=eve.holt@reqres.in    password=secret_123
    ${response} =     POST    url=${PATH_REGISTER}    json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()}[error]    Format didn't meet requirement