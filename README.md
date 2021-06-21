# README

* Ruby version used: 2.6.6

* Rails version used: 6.1.3.2

* In order to populate the db with some data, run:
  - rake populate:orders
  - rake populate:flowers

* There are specs for the controllers and the models
  -rspec spec/models/file.rb
  -rspec spec/requests/file.rb

* The main branch is "orders-2". It does not contain the auto-reload feature.
  That feature is present on the "auto-reload" branch.
  For that I used hotwire but the page does not fetch the data every 15 seconds.
  It happens instantly if a record is being created, edited or deleted.
  However, it is a little buggy because turbo-frame is not working well with html tables. (https://github.com/hotwired/turbo/issues/48)

* The "order-2" branch is also deployed on a heroku server.
  Heroku app: "orders-rails.herokuapp.com/"

* For the views I have used ".erb" files because that's how I learned to create views, but I have a separate branch called "haml-views-for-orders" where I converted all the ".erb" files into ".haml" files using "rake haml:erb2haml"