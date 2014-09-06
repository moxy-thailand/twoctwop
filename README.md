# 2c2p

This is a ruby wrapper for the 2c2p payment gateway

## Installation

Add this line to your application's Gemfile:

    gem 'twoctwop'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twoctwop

## Usage

First we need to create a request object

```ruby

request_hash = { 
  uniqueTransactionCode: 'M0001',                           # invoice number
  desc:                  'Polo Shirt',                      # order description
  amt:                   '000040000000',                    # must have 12 digits
  currencyCode:          764,                               # 764 for thai baht (based on http://en.wikipedia.org/wiki/ISO_4217)
  panBank:               iin_data['bank'],                  # Issuing Bank Name
  panCountry:            iin_data['country_code'],          # Issuing Bank Country
  cardholderName:        payment.details['name_on_card'],   # Card holder name
  encCardData:           payment.details['encrypted_card'], # Encrypted card data from payment form
}

request  = Twoctwop::Request.new(request_hash)
response = request.make_non_3ds_payment! # this will make the request and return a response
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/twoctwop/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request