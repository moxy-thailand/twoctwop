require 'openssl'

module Twoctwop

  class Response

    attr_accessor :certificate, :private_key, :body

    def initialize(body)
      raise "No private key defined" if Twoctwop::Config.private_key.nil?
      raise "No certificate defined" if Twoctwop::Config.certificate.nil?

      @certificate = OpenSSL::X509::Certificate.new(Twoctwop::Config.certificate)
      @private_key = OpenSSL::PKey::RSA.new(Twoctwop::Config.private_key, Twoctwop::Config.passphrase)

      @body = OpenSSL::PKCS7.new(Base64.strict_decode64(body))
    end

    def decrypt_body
      Hashie::Mash.new(Hash.from_xml(body.decrypt(private_key, certificate))['PaymentResponse'])
    end
  end
end