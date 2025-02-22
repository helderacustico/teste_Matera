*** Settings ***

Resource    ../src/kws.robot

*** Test Cases ***
CT01: Should return status code "200" when performing a GET request

    Given I send a GET request to "/breeds"                        1
    Then the status code of the response should be "200"

CT02: Performs validation of the keys returned in the request

    Given I send a GET request to "/breeds"                        1
    Then the status code of the response should be "200"
    Then the response should contain a list of cat breeds with the keys "breed", "country", "origin", "coat", and "pattern".

CT03: It must return the number of breeds according to the number entered in the parameter
    
    Given I send a GET request to "/breeds"                        5
    Then the status code of the response should be "200"
    Then the response body should contain at most 5 cat breeds     5

