require 'ox'

module Twoctwop

  class Response

    attr_accessor :certificate, :private_key, :body

    def initialize(body)
      @certificate = OpenSSL::X509::Certificate.new(Twoctwop::Config.certificate)
      @private_key = OpenSSL::PKey::RSA.new(Twoctwop::Config.private_key, '')

      @body = Base64.strict_decode64(body)
    end

    def decrypt
      data = OpenSSL::PKCS7.new(body)
      Ox.parse_object(data.decrypt(private_key, certificate))
    end
  end
end