@regression
Feature: Review project

  Scenario: EndToEnd account creation
    Given url "https://tek-insurance-api.azurewebsites.net/"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    And print generatedToken
    * def generator = Java.type('tiger.api.review.faker.DataGenerator')
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def DOB = generator.getDob()
    And print email
    And print firstName
    And print lastName
    And print DOB
    Given path '/api/accounts/add-primary-account'
    And request
      """  
       {
       "email": "#(email)",
       "firstName": "#(firstName)",
       "lastName": "#(lastName)",
       "title": "Mrs.",
       "gender": "FEMALE",
       "maritalStatus": "MARRIED",
       "employmentStatus": "student",
       "dateOfBirth": "2022-07-25T01:22:02.713Z",
       "new": true
       }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    * def ID = response.id
    And print response
    * def generator = Java.type('tiger.api.review.faker.DataGenerator')
    * def street = generator.getStreet()
    * def city = generator.getCity()
    * def state = generator.getState()
    * def country = generator.getCountry()
    * def zipCode = generator.getZipCode()
    * def countryCode = generator.getCountryCode()
    And print street
    And print city
    And print state
    And print country
    And print zipCode
    And print countryCode
    Given path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = ID
    And request
      """
      {
      "addressType": "#(addressType)",
      "addressLine1": "#(addressType)",
      "city": "#(city)",
      "state": "#(state)",
      "postalCode": "#(zipCode)",
      "countryCode": "#(countryCode)",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    * def generator = Java.type('tiger.api.review.faker.DataGenerator')
    * def phoneNumber = generator.getPhoneNumber()
    * def phoneExtension = generator.getPhoneExtension()
    And print phoneNumber
    And print phoneExtension
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = ID
    And request
      """
      {
        "phoneNumber": "#(phoneNumber)",
        "phoneExtension": "#(phoneExtension)",
        "phoneTime": "#(phoneTime)",
        "phoneType": "#(phoneType)"
      }
      """
    When method post
    Then status 201
    And print response
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = ID
    And request
      """
      {
        "make": "Honda",
        "model": "Civic",
        "year": "2019",
        "licensePlate": "444AAA"
      }
      """
    When method post
    Then status 201
    And print response
