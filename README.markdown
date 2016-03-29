## Introduction

This project was completed as part of the module 3 curriculum at the Turing School of Software and Design. We took an existing code base for an e-commerce site, and pivoted it to have a different business model, and added a layer of complexity through multitenancy (multiple shops hosted on the same site, with an additional platform admin role).

### Team

[Adrienne Domingus](https://github.com/adriennedomingus)  
[Brian Rippeto](https://github.com/brianrip)  
[Scott Firestone](https://github.com/scottfirestone)  

## Development

This project is built using Ruby on Rails and a PostgreSQL database, and uses services such as AWS and Paperclip for image storage, Stripe for payment processing, and SendGrid for email services.

It can be run locally on your machine by cloning the project down and running ```rake db:setup```.

### Test Suite
The test suite is built using MiniTest and tests both models and features. Feature tests are written using Capybara to mimic the user experience. To run the entire test suite, from the command line in the root of the app directory, run ```rake test```.

## Production

Our production app is hosted [here](abs-pivot.herokuapp.com) on Heroku.
