# Marketplacer API

This project is a Marketplacer API that includes functionalities such as handling products, users, and promotions.

## Prerequisites

- Docker
- Docker Compose

## Setup

To set up the application, run the following command:

`make setup`

This command will:

- Create the database
- Run migrations
- Seed the database with initial data (users and promotions)
- Load additional product data

## Running the Application

To start the application, run:

`make start`

The application will be available at `http://localhost:4000`.

## Running Tests

To run the test suite, use:

`make rspec`

This command will execute the RSpec test suite and generate the code coverage report.

## Shutting Down

To stop the application and remove the containers, use:

`make down`

## Promotion Service
### Promotion Model
Promotions are stored in the database with attributes such as threshold (the minimum cart total to apply the promotion) and discount (the discount percentage to be applied if the cart total exceeds the threshold).

### Promotion Service
The PromotionService is responsible for applying the correct promotion based on the cart total. It:

- Calculates the subtotal.
- Finds the applicable promotion.
- Calculates the discount.
- Updates the cart with the new totals.