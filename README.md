# Parliament Infection API

This API is responsible for interacting with the infection database.

## Configuration

* Ruby version = 2.7.1
* Authentication: JWT
* Database = Postgresql

## Deployment Instructions
### Development Environment
- Run ``` bundle install ``` in root directory
- Start server with ``` rails s ```
     - Default command runs server on ```localhost:3000```

## Endpoints:
- ```/submit ```
    - Puts temporary IDs in Infection table
    - Example Payload: 
    ```
    { 
      "username":"example@example.com", 
      "password":"password" 
    }
    ```
    - Example Successful Return:
    ```
    {
      result: addedEntries
    }
    
- ```/temp_ids ```
    - Login an existing user
    - Example Payload: 
    ```
    { 
      "accessToken":"1a2b3c4d5e6f7"
    }
    ```
    - Example Successful Return:
    ```
    {
         "tempIDs": {
         }
    }

    

