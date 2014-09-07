# 2c2p

This is a ruby wrapper for the 2c2p payment gateway

Currently this gem doesn't support 3ds payments, it makes a non_3ds payment which provides a smoother user experience.

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
  uniqueTransactionCode: 'M0001',                 # invoice number
  desc:                  'Polo Shirt',            # order description
  amt:                   '000040000000',          # must have 12 digits
  currencyCode:          764,                     # 764 for thai baht (based on http://en.wikipedia.org/wiki/ISO_4217)
  panBank:               'Siam Commercial Bank',  # Issuing Bank Name
  panCountry:            'TH',                    # Issuing Bank Country
  cardholderName:        'Zack Siri',             # Card holder name
  encCardData:           'iamencrypteddata'       # Encrypted card data from payment form
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