require "twoctwop/version"
require "twoctwop/config"
require "twoctwop/request"
require "twoctwop/response"

module Twoctwop
  extend Config

  def self.root
    File.expand_path '../..', __FILE__
  end
end

