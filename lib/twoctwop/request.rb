require 'base64'
require 'openssl'
require 'rest-client'
require 'hashie'

module Twoctwop
  class Request

    attr_accessor :data, :env, :digest

    ENDPOINT = { 
      test: 'http://demo2.2c2p.com/2C2PFrontEnd/SecurePayment/Payment.aspx',
      live: ''
    }

    def initialize(data = {})
      raise "Merchant ID is nil" if Twoctwop::Config.merchant_id.nil?
      raise "Secret key is nil"  if Twoctwop::Config.secret_key.nil?
      @digest  = OpenSSL::Digest.new('sha1')

      @data = data
      @env  = Twoctwop::Config.env == 'production' ? :live : :test
    end

    def endpoint
      ENDPOINT[env]
    end

    def payload
      Base64.strict_encode64(build_final_data.to_xml(root: 'PaymentRequest', 
                                                     skip_instruct: true, 
                                                     skip_types: true, 
                                                     indent: 0))
    end

    def make_non_3ds_payment!
      body = RestClient.post endpoint, :paymentRequest => payload
      Response.new(body).decrypt_body
    end

  private

    def build_final_data
      data.merge({
        version: '8.0',
        merchantID: Twoctwop::Config.merchant_id,
        hashValue: calculate_hash_data_digest
      })
    end

    def calculate_hash_data_digest
      hash_data = [Twoctwop::Config.merchant_id, data[:uniqueTransactionCode], data[:amt]].join
      OpenSSL::HMAC.hexdigest(digest, Twoctwop::Config.secret_key, hash_data)
    end

  end
end