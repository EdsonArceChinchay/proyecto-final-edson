Feature: Obtener producto por id

  Background:
    * def reusableToken = call read('classpath:bdd/auth/loginAuth.feature@token')
    * print reusableToken
    * def tokenLogin = reusableToken.token
    * url "https://api.qateamperu.com"

  @automation-api
  Scenario: CP-01 - Obtener producto por id
    * def id = 1061
    Given path "/api/v1/producto/" + id
    * print tokenLogin
    And header Authorization = 'Bearer ' + tokenLogin
    When method get
    Then status 200
    And match response.id == id
    * print response


  @automation-api
  Scenario Outline: CP02 - Obtener producto por id con ejemplos
    Given path "/api/v1/producto/" + "<id>"
    * print tokenLogin
    And header Authorization = 'Bearer ' + tokenLogin
    When method get
    Then status 200
    And match response.id == <id>
    * print response

    Examples:
      |id|
      |1061|
      |1062|
