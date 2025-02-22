*** Settings ***

Library     RequestsLibrary
Library     Collections

*** Variables ***

${baseUrl}    https://catfact.ninja

*** Keywords ***

Given I send a GET request to "/breeds"
    [Arguments]            ${limit}
    Create Session         Cat_api                ${baseUrl}
    ${params}              Create Dictionary      limit=${limit}
    ${response}            GET On Session         cat_api    /breeds    params=${params}
    Set Global Variable    ${response}

Então o “status code” do response deve ser “200”
    
    Should Be Equal As Numbers    ${response.status_code}    200

Then the status code of the response should be "200"
    Então o “status code” do response deve ser “200”
    
    Should Be Equal As Numbers    ${response.status_code}    200
    
Then the response should contain a list of cat breeds with the keys "breed", "country", "origin", "coat", and "pattern".
    
    ${json}        Set Variable       ${response.json()}    
    Dictionary Should Contain Key     ${json}                data    
    ${count}       Get Length         ${json["data"]}    
    Set Global Variable    ${count}

    FOR    ${item}    IN    @{json["data"]}
        Dictionary Should Contain Key    ${item}    breed
        Dictionary Should Contain Key    ${item}    country
        Dictionary Should Contain Key    ${item}    origin
        Dictionary Should Contain Key    ${item}    coat
        Dictionary Should Contain Key    ${item}    pattern
    END
    #Should Be True    ${count} > 0

Then the response body should contain at most 5 cat breeds
    
    [Arguments]    ${numeroRacas}
    ${json}        Set Variable       ${response.json()}    
    Dictionary Should Contain Key     ${json}                data    
    ${count}       Get Length         ${json["data"]}    
    Set Global Variable    ${count}

    Should Be Equal As Numbers    ${count}    ${numeroRacas}