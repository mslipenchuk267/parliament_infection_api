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
    - Puts temporary IDs in Infection database
    - Example Payload: 
    ```
    { 
      "accessToken":"1a2b3c4d5e6f7"
      "tempIDs" : ["00000000-0000-0000-0000-905f5a19f5e9", "00000000-0000-0000-0000-905f5a19f5e9", "00000000-0000-0000-0000-905f5a19f5e9"]
    }
    ```
    - Example Successful Return:
    ```
    {
      "result" : ["00000000-0000-0000-0000-905f5a19f5e9", "00000000-0000-0000-0000-905f5a19f5e9", "00000000-0000-0000-0000-905f5a19f5e9"]
    }
- ```/temp_ids ```
    - Gets temporary IDs from Infection database
    - Example Payload: 
    ```
    { 
      "accessToken":"1a2b3c4d5e6f7"
    }
    ```
    - Example Successful Return:
    ```
    {
     {
    "temp_ids" : [{"temp_id":"00000000-0000-0000-0000-905f5a19f5e9","created_at":"2020-11-01T18:23:24.731Z"},{"temp_id":"00000000-0000-0000-0000-80df5b1111f2","created_at":"2020-11-02T18:23:24.731Z"},{"temp_id":"00000000-0000-0000-0000-711fabfa2122","created_at\":\"2020-11-03T18:23:24.731Z"}]
     }
    }
