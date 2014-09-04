require 'base64'
require 'digest/hmac'

module Twoctwop
  class Request

    attr_accessor :data

    def initialize(data = {})
      raise "Merchant ID is nil" if Twoctwop::Config.merchant_id.nil?
      raise "Secret key is nil"  if Twoctwop::Config.secret_key.nil?

      @data = data
      build_final_data!
    end

    def encoded_request
      Base64.strict_encode64(data)
    end

  private

    def build_final_data!
      data.merge({
        merchantID: Twoctwop::Config.merchant_id,
        hashValue: calculate_hash_data_digest
      })
    end

    def calculate_hash_data_digest
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