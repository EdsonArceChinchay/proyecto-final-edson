Feature: Actualizar produdctos
  Background:
    * def reusableToken = call read('classpath:bdd/auth/loginAuth.feature@token')
    * print reusableToken
    * def tokenLogin = reusableToken.token
    * url "https://api.qateamperu.com"

  @automation-api
  Scenario: CP01 - Actualizar producto forma 1
    * def payload = read('classpath:resources/json/auth/product.json')
    * def id = 1061
    Given path "/api/v1/producto/" + id
    * print tokenLogin
    And header Authorization = 'Bearer ' + tokenLogin
    And request payload
    When method put
    Then status 200
    And match response.id == id
    * print response

  @automation-api
  Scenario Outline: CP02 - Actuzalizar producto forma 2
    * def payload = {"codigo": #(codigo), "nombre": #(nombre), "medida": #(medida), "marca": #(marca), "categoria": #(categoria), "precio": #(precio), "stock": #(stock), "estado": #(estado), "descripcion": #(descripcion)}
    * def id = 1062
    Given path "/api/v1/producto/" + id
    * print tokenLogin
    And header Authorization = 'Bearer ' + tokenLogin
    And request payload
    When method put
    Then status 200
    And match response.id == id
    And match response.codigo == "<codigo>"
    And match response.descripcion == "<descripcion>"

    Examples:
      | read('classpath:resources/csv/auth/product.csv')|