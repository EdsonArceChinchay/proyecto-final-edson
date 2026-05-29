Feature: Registro usuarios


  Background:
  * url "https://api.qateamperu.com"

  @automation-api
  Scenario: CP01 - Registro de usuario
    * def payload = read('classpath:resources/json/auth/registerUser.json')
    ##Given url "https://api.qateamperu.com"
    And path "/api/register"
    And request payload
    When method post
    Then status 200
    And match response.data.nombre == payload.nombre
    And match response.data.email == payload.email

  @automation-api
  Scenario: CP02 - Registro de usuario forma 2
    And path "/api/register"
    And request
  """
  {
  "email": chincha@gmail.com,
  "password": "12345678",
  "nombre": Luis,
  "tipo_usuario_id": 1,
  "estado": 1
  }
  """
    When method post
    Then status 200
    And match response.data.nombre == "Luis"
    And match response.data.email == "chincha@gmail.com"
