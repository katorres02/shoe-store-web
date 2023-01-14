# README

This is a solution to the problem described in https://github.com/mathieugagne/shoe-store.

* Allows the users to see all new sales in real-time
* Generate a suggestions report for those stores with low inventory - What this means is the dashboard will suggest you to move shoes from a high inventory store to a low one

This solution was made using:
* Ruby on Rails
* sidekiq
* redis
* postgresql
* react
* GraphQL

## Ruby version

2.7.5

## System dependencies

* Postgresql
* Redis
* Sidekiq
* websocketd
* NodeJs

# Setup Guide
## Installation
* Clone this project `git clone git@github.com:katorres02/shoe-store-web.git`
* `cd shoe-store-web`
* Install gems `bundle innstall`
* Instal node packages `npm install`

## Configure environment variables
* Create a `.env` file in the root folder
* Set the following variables according to your system
```
DATABASE_USERNAME=
DATABASE_PASSWORD=
DATABASE_HOST=localhost
DATABASE_PORT=5432
WEBSOCKET_URL=ws://localhost:8080/
REDIS_URL=redis://localhost:6379
```

## Install Redis
* Detailed insntructions in redis webpage https://redis.io/docs/getting-started/installation/install-redis-on-mac-os/
* make sure redis is runninng

## Database configuration
* Run `rails db:create db:migrate`

## How to run the test suite
* All backend code is covered by unit tests using `rspec`
* Run `rspec` or `bundle exec rspec`

## Websocket Server
* Clone this repository https://github.com/mathieugagne/shoe-store
* Install `websocketd`

# How to start the project
* Start postgreql
* Start redis
* Open a new terminal and go to the websocket server folder
* Run `websocketd --port=8080 ruby inventory.rb`
* Open a new terminal and got to this project folder - then start the sidekiq process
* Run `bundle exec sidekiq`
* Open a new terminal and got to this project folder - then start the rake task that will start listening for events
* Run `rake shoe_store:pull_events`
* Open a new terminal and got to this project folder - then start ruby on rails process
* Run `bin/dev`
* Open your browser and visit `http://localhost:3000`


## Description
<img width="1673" alt="image" src="https://user-images.githubusercontent.com/1949867/211715281-d5fe6aa7-c3e3-4ea7-8884-878ea880cd4a.png">

Left side you can see the on-going sales being processed at real time.

Rifht side you will get a list of suggestions for moving inventory from a big supply store to a low supply one.

Low supply is calculated as `inventory < 15`

High supply is calculated as `inventory > 70`

## Full Architecture 
![Untitled](https://user-images.githubusercontent.com/1949867/212494041-3736a13a-f6be-4b71-b945-066155704ba1.png)

1. Listen the websocket for new events using a rails `rake task`in a separate *thread*
2. This rake task will queue the new event into `Sidekiq` to be processed in *background*  - This will prevent *bottle neck* during processing
3. `Sidekiq` will store this task into `redis` for future processing
4. Once the queue is available - `sidekiq` will grab the process stored in `redis` and will start procesing by calling a custom module `HigeFlashSale`
5. This module is responsible to store this information into `db-postgres`
6. Once the information is saved, rail with `broadcast` a custom `json object` via `Action Cable`
7. `Action Cable` sends this json to all the listeners
8. The front-end is using a `react` component that will listen for this events and will render the info
9. React components update automatically every time a new event is broadcasted via Action cable
10. The suggestion resport works in the same way, `backend-actioncable-react`

## ADDITIONA NOTES
The first time you open the browser with the project running, the front-end will attempt to get the latest information from the backend via the `graphql`
api

## GraphQL API
Use any rest client like `postman`

1. Get all stored sales
```grapqhl
      shoes {
        customId
        id
        model
        inventory
        alert
        store {
          id
          name
        }
      }
```
Expected response



```json
{
    "data": {
        "shoes": [
            {
                "customId": "734",
                "id": "34",
                "model": "ABOEN",
                "inventory": 33,
                "alert": "white",
                "store": {
                    "id": "7",
                    "name": "ALDO Pheasant Lane Mall"
                }
            },
             ]
            }}
```


2. Get a suggestions report
```graphql
    suggestionsReport{
        id
        low
        high
    }
```
Expected response

```json
{
    "data": {
        "suggestionsReport": [
            {
                "id": "494",
                "low": {
                    "customId": "44",
                    "id": 4,
                    "model": "VENDOGNUS",
                    "alert": "red",
                    "inventory": 4,
                    "store": {
                        "id": 4,
                        "name": "ALDO Auburn Mall"
                    }
                },
                "high": {
                    "customId": "194",
                    "id": 94,
                    "model": "VENDOGNUS",
                    "alert": "green",
                    "inventory": 77,
                    "store": {
                        "id": 1,
                        "name": "ALDO Waterloo Premium Outlets"
                    }
                }
            },
 ]}}
```
