# DNSimple Ruby Client

A Ruby client for the [DNSimple API](https://developer.dnsimple.com/).

[![Build Status](https://travis-ci.org/aetrion/dnsimple-ruby.svg?branch=master)](https://travis-ci.org/aetrion/dnsimple-ruby)
[![Coverage Status](https://img.shields.io/coveralls/aetrion/dnsimple-ruby.svg)](https://coveralls.io/r/aetrion/dnsimple-ruby?branch=master)

[DNSimple](https://dnsimple.com/) provides DNS hosting and domain registration that is simple and friendly.
We provide a full API and an easy-to-use web interface so you can get your domain registered and set up with a minimal amount of effort.


## Installation

```
$ gem install dnsimple
```


## Getting Started

This library is a Ruby client you can use to interact with the [DNSimple API](https://developer.dnsimple.com/). Here are some examples.

```ruby
require 'dnsimple'

client = Dnsimple::Client.new(username: 'YOUR_USERNAME', api_token: 'YOUR_TOKEN')

# Fetch your user details
user = client.users.user
puts "My email is #{user.email}"


# List your domains
domains = client.domains.list
domains.each do |domain|
  puts "Domain: %s (id: %d)" % [domain.name, domain.id]
end

# Create a domain
domain = client.domains.create(name: "example.com")
puts "Domain: %s (id: %d)" % [domain.name, domain.id]

# Get a domain
domain = client.domains.domain("example.com")
puts "Domain: %s (id: %d)" % [domain.name, domain.id]


# Create a domain record
record = client.domains.create_record("example.com", record_type: "A", name: "www", content: "127.0.0.1")
puts "Record: %s (id: %d)" % [record.name, record.id]

# Get a domain record
record = client.domains.record("example.com", 1234)
puts "Record: %s (id: %d)" % [record.name, record.id]

# List domain records
records = client.domains.records("example.com")
records.each do |record|
  puts "Record: %s (id: %d)" % [record.name, record.id]
end
```

For the full library documentation visit http://rubydoc.info/gems/dnsimple


## Authentication

This client supports both the HTTP Basic and API Token authentication mechanism.

#### HTTP Basic

```ruby
client = Dnsimple::Client.new(username: 'YOUR_USERNAME', password: 'YOUR_PASSWORD')
client.users.user
# => Dnsimple::Struct::User
```

#### HTTP Basic with two-factor authentication enabled

See the [2FA API documentation](https://developer.dnsimple.com/authentication/#twofa).

```ruby
# Request the 2FA exchange token
client = Dnsimple::Client.new(username: 'YOUR_USERNAME', password: 'YOUR_PASSWORD')
token  = client.users.exchange_token('otp-token')

# Authenticate with the exchange token
client.exchange_token = token
client.users.user
# => Dnsimple::Struct::User
```

#### API Token

```ruby
client = Dnsimple::Client.new(username: 'YOUR_USERNAME', api_token: 'YOUR_TOKEN')

client.users.user
# => Dnsimple::Struct::User
```

#### Domain API Token

The domain API token grants [limited access]](https://developer.dnsimple.com/v1/authentication/#domain-token) to a single domain.

```ruby
client = Dnsimple::Client.new(domain_api_token: 'DOMAIN_TOKEN')

client.domains.records("example.com")
# => [Dnsimple::Struct::Record, Dnsimple::Struct::Record, ...]

client.domains.records("foobar.com")
# => Authentication error
```

## License

Copyright (c) 2010-2015 Aetrion LLC. This is Free Software distributed under the MIT license.
