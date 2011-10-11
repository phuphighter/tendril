# Google Places

Ruby wrapper for the [Tendril API](https://groups.google.com/forum/#!forum/tendril-app-dev).

## Installation

Inside your Gemfile:
  gem 'tendril'
    
## Usage

### Instantiate a client

    >> @client = @client = Tendril::Client.new(:email => "email", :password => "password", :subdomain => "subdomain")
    
## Examples

#### Request pricing schedule

    >> @pricing = @client.pricing("schedule", :from => "2011-10-09T21:45:08-0500", :to => "2011-10-11T21:45:08-0500", :"external-account-id" => "account_id")
    
#### Request meter data

    >> @meter = @client.meter("consumption", :from => "2010-10-09T21:45:08-0500", :to => "2010-10-10T21:45:08-0500", :"external-account-id" => "account_id")
    
    >> @meter = @client.meter("read", :from => "2010-05-09T21:45:08-0500", :to => "2010-05-10T21:45:08-0500", :"external-account-id" => "account_id")

## Copyright

Contact me if you have any suggestions and feel free to fork it!

Copyright (c) 2009 Johnny Khai Nguyen, released under the MIT license
