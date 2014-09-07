require 'base64'
require 'openssl'
require 'rest-client'
require 'builder'
require 'hashie'

module Twoctwop
  class Request

    attr_accessor :data, :env, :digest, :token

    ENDPOINT = { 
      test: 'http://demo2.2c2p.com/2C2PFrontEnd/SecurePayment/Payment.aspx',
      live: ''
    }

    def initialize(data: {}, token: nil)
      raise "Merchant ID is nil" if Twoctwop::Config.merchant_id.nil?
      raise "Secret key is nil"  if Twoctwop::Config.secret_key.nil?

      @token = token
      @digest = OpenSSL::Digest.new('sha1')

      @data = data
      @env  = Twoctwop::Config.env == 'production' ? :live : :test
    end

    def endpoint
      ENDPOINT[env]
    end

    def payload
      Base64.strict_encode64(build_request)
    end

    def make_non_3ds_payment!
      body = RestClient.post endpoint, :paymentRequest => payload
      binding.pry
      Response.new(body).decrypt_body
    end

  private

    def build_request
      final_hash = build_final_hash

      Builder::XmlMarkup.new.PaymentRequest do |p|
        final_hash.keys.each do |k|
          p.tag!(k, final_hash[k]) 
        end
      end
    end

    def build_final_hash
      data.merge({
        version: '8.0',
        merchantID: Twoctwop::Config.merchant_id,
        hashValue: calculate_hash_data_digest,
      }).merge(store_card_token)
    end

    def store_card_token
      token ? { storeCard: 'Y', storeCardUniqueID: token } : {}
    end

    def calculate_hash_data_digest
      hash_data = [Twoctwop::Config.merchant_id, data[:uniqueTransactionCode], data[:amt]].join
      OpenSSL::HMAC.hexdigest(digest, Twoctwop::Config.secret_key, hash_data)
    end

  end
end