module Twoctwop
  # change the config in an initializer like so

  # Twoctwop::Config.merchant_id = '111'
  # Twoctwop::Config.secret_key  = '12345678'

  # Or use the block

  # Twoctwop::Config.configure do |config|
  #   config.merchant_id = '111'
  #   config.secret_key  = '12345678'
  # end

  module Config
    extend self

    attr_accessor :merchant_id, :secret_key

    def configure
      yield self  
    end
  end
end