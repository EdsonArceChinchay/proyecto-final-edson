Feature: Agregar producto
   Background:
      * def reusableToken = call read('classpath:bdd/auth/loginAuth.feature@token')
      * print reusableToken
      * def tokenLogin = reusableToken.token
      * url "https://api.qateamperu.com"

  @automation-api
   Scenario: CP01 - Agregaro producto forma 1
      * def payload = read('classpath:resources/json/auth/product.json')
        Given path "/api/v1/producto"
        * print tokenLogin
        And header Authorization = 'Bearer ' + tokenLogin
        And request payload
        When method post
        Then status 200
        And match response contains payload
        * print response

  @automation-api
  Scenario: CP02 - Agregaro producto forma 2
      * def payload = read('classpath:resources/json/auth/product.json')
      Given path "/api/v1/producto"
      * print tokenLogin
      And header Authorization = 'Bearer ' + tokenLogin
      And request payload
      When method post
      Then status 200
      And match response.codigo == payload.codigo
      And match response.descripcion == payload.descripcion
      * print response


  @automation-api
  Scenario Outline: CP03 - Agregar producto con ejemplos
      * def payload = {"codigo": #(codigo), "nombre": #(nombre), "medida": #(medida), "marca": #(marca), "categoria": #(categoria), "precio": #(precio), "stock": #(stock), "estado": #(estado), "descripcion": #(descripcion)}
      Given path "/api/v1/producto"
      * print tokenLogin
      And header Authorization = 'Bearer ' + tokenLogin
      And request payload
      When method post
      Then status 200
      And match response.codigo == "<codigo>"
      And match response.descripcion == "<descripcion>"
      * print response

      Examples:
        | read('classpath:resources/csv/auth/product.csv')|
