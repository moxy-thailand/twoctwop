require 'base64'
require 'digest/hmac'

module Twoctwop
  class Request

    attr_accessor :data

    ENDPOINT = { 
      test: 'http://demo2.2c2p.com/2C2PFrontEnd/SecurePayment/Payment.aspx',
      live: ''
    }

    SECURE_ENDPOINT = {
      test: '',
      live: ''
    }

    def initialize(data = {})
      raise "Merchant ID is nil" if Twoctwop::Config.merchant_id.nil?
      raise "Secret key is nil"  if Twoctwop::Config.secret_key.nil?

      @data = build_final_data(data)
    end

    def make_payment!
      RestClient.post endpoint, :paymentRequest => Base64.strict_encode64(data)
    end

  private

    def endpoint
      ENDPOINT[(Rails.env.production? ? :live : :test)]
    end

    def secure_endpoint
      
    end

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