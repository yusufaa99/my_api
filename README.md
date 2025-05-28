# Welcome to My Api
***

## Task
The goal of this project is to provide a RESTful API for managing football (leagues, teams, players and matches) data. The challenge lies in implementing secure user authentication and providing robust data manipulation capabilities while ensuring data integrity and performance.
## Description
This API allows users to authenticate using Doorkeeper OAuth, enabling secure access to the football database. Users can log in, create accounts, and perform CRUD operations on the football records. The API is designed to serve both Postman users for testing and a GraphQL interface for convenient browser interaction.

## Installation
1. Prerequisites
    - [Ruby](https://rvm.io/)
    - [PostgreSQL](https://www.postgresql.org/)
    - [Redis](https://redis.io/)

2. Make sure you have the following versions (or compatibles) installed on your machine.
    - Node => v20.15.0
    - Yarn => 1.22.22
    - ruby => 3.1.5p252
    - Rails => 7.2.1

To install the project, follow these steps:
1. Clone the repository:
    ```bash
    git clone https://github.com/yusufaa99/my_api.git
    ```
    ```bash
    cd my_api
    ```
2. Install dependencies:
    ```bash
    bundle install
    ```
3. Set up the database:
    ```bash
    rails db:create
    ```
    ```bash
    rails db:migrate
    ```
    ```bash
    rails db:seed
    ```
4. Run the server:
    ```bash
    rails server
    ```
## Usage
### Postman Documentation
First, Verify the Client Application Exists
In your Rails console (rails c):
```bash
rails c
>   Doorkeeper::Application.all.each do |app|
        puts "ID: #{app.id}, Name: #{app.name}, Client ID: #{app.uid}, Client Secret: #{app.secret}"
    end
```
OR
Recreate the OAuth Application (Optional)
```bash
rails c
> app = Doorkeeper::Application.create!(
    name: "New App", 
    redirect_uri: "", 
    scopes: "", 
    uid: SecureRandom.hex(16), 
    secret: SecureRandom.hex(32)
  )
```
1. Authenticate User/Admin to get the access token 
- **Endpoint:** POST /api/v1/oauth/token
    http://localhost:3000/oauth/token
- **Parameters:**
    - **grant_type:** password
    - **email:** User's email
    - **password:** User's password
    - **client_id:** Application's id
    - **client_secret:** Application's secret
- **Example Request**
    ```JSON
    {
    "grant_type": "password",
    "email": "yusufyahaya065@gmail.com",
    "password": "letmein123",
    "client_id": "710d8986884a6459794ccb29f9f97c60",
    "client_secret": "a64825a4e2c80f2435d1ce7724c7ecd377dd6d15219147ab060f8a57b3d807c7"
    }

    ```
- **Example Respond:**
    ```JSON
    {
        "access_token": "The access token",
        "token_type": "Bearer",
        "expires_in": 7200,
        "refresh_token": "The refresh token",
        "created_at": 1728231096
    }
    ```
2. To get the **client_id** and the **client_secret**, follow the following steps
- Open the Rails console:
    ```bash
    rails console
    ```
- Retrieve the Client ID and Secret
    ```bash
    app = Doorkeeper::Application.last
    ```
    ```bash
    app.uid # This is the client ID
    ```
    ```bash
    app.secret # This is the client secret
    ```
3. Create User (None Admin User)
- **Endpoint:** POST /api/v1/users 
- **Parameters:** Provide necessary user details in the request body.
    - **email:** User's email
    - **password:** User's password
    - **client_id:** Application's id
- **Description:** This endpoint allows for the creation of a new user account.
- **Example Request:** 
    ```JSON
    {
        "email": "user@gmail.com",
        "password": "password",
        "client_id": "Application's id"
    }
    
    OR
    {
        "email": "newuser@example.com",
        "password": "password123",
        "password_confirmation": "password123",
        "role": "user",
        "client_id": "Application's id"
    }
    ```
- **Example Response:**
    ```JSON
    {
        "id": 3,
        "email": "user@gmail.com",
        "role": "user",
        "access_token": "0iR7Yo11KQ49nxvYDkjngyJP55uTvOlscS6rv2rtnzQ",
        "token_type": "Bearer",
        "expires_in": 7200,
        "refresh_token": "ceb070638397c9831f26f6e29de920f17ebba311b75e4a41777ef5b753328bec",
        "created_at": 1728209879
    }
    ```
4. Access league Data
- **Endpoint:** GET /api/v1/leagues
- **Headers:**
    - Authorization: Bearer <access_token>
- **Description:** Fetch a list of league records with pagination (max 20 elements per page). Use the access token obtained from the authentication step. 
5. Set Up Authorization in Postman
- In Postman, for each request (create, update, delete), set the Authorization header:
    - Click on the **Authorization** tab.
    - Under **Type**, select **Bearer Token**.
    - Paste the access token you received from the login request.
6. Create a New league Record
    - **Endpoint:**
    ```
    POST /api/v1/leagues
    ```
    - **Headers:**

    ```JSON
    {
        "Content-Type": "application/json",
        "Authorization": "Bearer <your_access_token>"
    }
    ```
    - **Request Body:**
    ```JSON
    {
        "league": {
            "name": "New League",
            "country": "Country Name",
            "season": "2025",
            "founded": 1995,
            "division": "Premier"
        }
     }
    
    ```
    - **Response:** You should receive a 201 Created response if successful, with the newly created league record as the following.
    ```json
    {
        "id": 11,
        "name": "New League",
        "country": "Country Name",
        "season": "2025",
        "founded": 1995,
        "division": "Premier",
        "created_at": "2025-02-01T12:00:00Z",
        "updated_at": "2025-02-01T12:00:00Z"
    }

    ```
7. Update an Existing League Record
    - **Endpoint:**
    ```
    PUT /api/v1/leagues/:id
    ```
    Replace **:id** with the ID of the league record you want to update.
    - **Headers:**
    ```json
        {
            "Content-Type": "application/json",
            "Authorization": "Bearer <your_access_token>"
        }
    ```
    - **Request Body:**
    ```json
        {
            "league": {
                "name": "Updated League Name",
                "country": "Updated Country",
                "season": "2026",
                "founded": 1990,
                "division": "League 1"
            }
        }

    ```
    - **Response:** You should receive a 200 OK response if the update was successful, along with the updated league record as the following.
    ```json
        {
            "id": 1,
            "name": "Updated League Name",
            "country": "Updated Country",
            "season": "2026",
            "founded": 1990,
            "division": "League 1",
            "created_at": "2025-02-01T12:00:00Z",
            "updated_at": "2025-02-01T12:00:00Z"
        }

    ```
8. Delete an League Record
    - **Endpoint:**
    ```
    DELETE /api/v1/leagues/:id
    ```
    Replace **:id** with the ID of the league record you want to delete.
    - **Headers:**
    ```json
        {
            "Authorization": "Bearer <your_access_token>"
        }
    ```
    - **Response:** You should receive a 204 No Content response if the deletion was successful.
### Accessing the Hosted version (Postman)
You can access the hosted version of the API via the following link as seen in the postman documentation using all the corresponding enpoints 
    ```bash
    https://my-api-zssd.onrender.com
    ```

### GraphQL Interface
1. Accessing the GraphQL Interface
- Navigate to http://localhost:3000/graphiql in your web browser to access the GraphQL interface.
- **Limitation** I couldn't implement the Doorkeeper Oauth to work with the GraphQL Interface but you can locally perform the following queries and mutations on your browser.
2. Query League
    - Example Query:
    ```graphql
    query {
        leagues(page: 1, perPage: 10) {
            id
            name
            country
            season
        }
        
        matches(page: 2, perPage: 5, dateAfter: "2025-01-01T00:00:00Z") {
            id
            homeTeamId
            awayTeamId
            matchDate
        }
        
        players(page: 1, perPage: 20, position: "Forward") {
            id
            name
            position
        }
        
        teams(page: 1, perPage: 15) {
            id
            name
            stadium
        }
    }


    ```
    - **Description:** This query retrieves a list of all leagues from the database with pagination (max 20 elements per page).
   
3. Create League
    - Example Mutation:
    ```graphql
    mutation {
    createLeague(
        input: {
            name: "New League"
            country: "Country Name"
            season: "2025"
            founded: 1995
            division: "Premier"
            }
    )   {
    league {
            id
            name
            country
            season
            founded
            division
        }
        errors
        }
    }

    ```
4. Update League Record
- Example Mutation:
    ```graphql
    mutation {
    updateLeague(
        input: {
            id: "1"  # The ID of the league you're updating
            name: "Updated League Name"
            country: "Updated Country"
            season: "2026"
            founded: 1990
            division: "League 1"
        }
    ) {
        league {
            id
            name
            country
            season
            founded
            division
        }
        errors
        }
    }

    ```
    - **Note** All the fields should be there but do not change the id
4. Delete League
- Example Mutation:
    ```graphql
    mutation {
    deleteLeague(input: { id: "1" }) {
        league {
            id
        }
        errors
        }
    }

    ```

### Postman Documentation Link
The following link to access the postman documentation
    ```
        https://documenter.getpostman.com/view/41622568/2sAYX5K2qd
    ```
### The Core Team
Yusuf Yahaya usman Fulani

<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering Schools Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
