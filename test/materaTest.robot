*** Settings ***

Resource    ../src/kws.robot

*** Test Cases ***
CT01: Should return status code "200" when performing a GET request

    Given I send a GET request to "/breeds"                        1
    Then the status code of the response should be "200"

CT02: Realiza validação das chaves retornadas na requisição

    Given I send a GET request to "/breeds"                        1
    Then the status code of the response should be "200"
    Then the response should contain a list of cat breeds with the keys "breed", "country", "origin", "coat", and "pattern".

CT03: Deve retornar a quantidade de raças de acordo com o número informado no parâmetro
    
    Given I send a GET request to "/breeds"                        5
    Then the status code of the response should be "200"
    Then the response body should contain at most 5 cat breeds     5

