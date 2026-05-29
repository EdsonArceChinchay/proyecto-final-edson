Feature: Login usuarios

    Background:
    * url "https://api.qateamperu.com"

    @automation-api @token
    Scenario Outline: CP01 - Login de usuario
        * def payload = { email: #(email), password: #(password) }
        And path "/api/login"
        And request payload
        * print payload
        When method post
        Then status 200
        And match response.user.email == "<email>"
        * def token = response.access_token
        * print token

    Examples:
        |read('classpath:resources/csv/auth/dataLogin.csv')|


    @automation-api
    Scenario: CP02 - Login de usuario con docString
        * def payload = read('classpath:resources/json/auth/bodyLogin.json')
        And path "/api/login"
        And request payload
        * print payload
        When method post
        Then status 200
        And match response.user.email == payload.email
