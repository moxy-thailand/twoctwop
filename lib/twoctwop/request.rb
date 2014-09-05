require 'base64'
require 'digest/hmac'

module Twoctwop
  class Request

    attr_accessor :data, :env

    ENDPOINT = { 
      test: 'http://demo2.2c2p.com/2C2PFrontEnd/SecurePayment/Payment.aspx',
      live: ''
    }

    SECURE_ENDPOINT = {
      test: 'http://demo2.2c2p.com/2C2PFrontEnd/SecurePayment/PaymentAuth.aspx',
      live: ''
    }

    def initialize(data = {})
      raise "Merchant ID is nil" if Twoctwop::Config.merchant_id.nil?
      raise "Secret key is nil"  if Twoctwop::Config.secret_key.nil?

      @data = build_final_data(data)
      @env  = Twoctwop::Config.env == 'production' ? :live : :test
    end

    def endpoint
      ENDPOINT[env]
    end

    def secure_endpoint
      SECURE_ENDPOINT[env]
    end

    def payload
      Base64.strict_encode64(payment_request)
    end

    def make_non_3ds_payment!
      body = RestClient.post endpoint, :paymentRequest => payload
      response = Response.new(body).descrypt
    end

  private

    def build_final_data(data)
      data.merge({
        merchantID: Twoctwop::Config.merchant_id,
        hashValue: calculate_hash_data_digest(data)
      })
    end

    def calculate_hash_data_digest(data)
      hash_data = [Twoctwop::Config.merchant_id, data[:uniqueTransactionCode], data[:amt]].join
      Digest::HMAC.hexdigest(hash_data, Twoctwop::Config.secret_key, Digest::SHA1)
    end

    def payment_request
      Builder::XmlMarkup.new.PaymentRequest do |p|
        data.keys.each do |k|
          p.send(k, data[k]) 
        end
      end
    end

  end
end