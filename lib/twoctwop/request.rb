require 'base64'
require 'openssl'
require 'rest-client'
require 'builder'
require 'hashie'

module Twoctwop
  class Request

    attr_accessor :data, :digest, :token


    def initialize(data: {}, token: nil)
      raise "Set end point"      if Twoctwop::Config.endpoint.nil?
      raise "Merchant ID is nil" if Twoctwop::Config.merchant_id.nil?
      raise "Secret key is nil"  if Twoctwop::Config.secret_key.nil?

      @token = token
      @digest = OpenSSL::Digest.new('sha1')

      @data = data
    end

    def endpoint
      Twoctwop::Config.endpoint
    end

    def payload
      Base64.strict_encode64(build_request)
    end

    def make_non_3ds_payment!
      body = RestClient.post endpoint, :paymentRequest => payload
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