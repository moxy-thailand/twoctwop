# 2c2p

[ ![Codeship Status for codemy/twoctwop](https://codeship.io/projects/e177b320-18a3-0132-1aba-4eb52c1571b2/status)](https://codeship.io/projects/34256)

2c2p: A ruby wrapper for the 2c2p payment gateway

This gem supports NON 3DS payment, enabling a seamless customer experience.
Feel free to fork, edit, and add to this gem, and please help us open source 
more projects like this in order to help combat the horrific monster that is 
digital payments in Thailand. We can do it if we work together!

  -> MOXY




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

request  = Twoctwop::Request.new(data: request_hash)
response = request.make_non_3ds_payment! # this will make the request and return a response
```

To Save the card into 2c2p you just need to add the token

```ruby
request = Twoctwop::Request.new(data: request_hash, token: 'blah')
```

This will save the token and you can make payments using tokens instead of the card information. You can generate any token you want from your application as long as you can reference it again when you need to pass it into the `Twoctwop::Request` object.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/twoctwop/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request