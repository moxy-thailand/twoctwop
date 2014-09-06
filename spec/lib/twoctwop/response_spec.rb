require 'spec_helper'
require 'pry'

module Twoctwop
  describe Response do 
    include_context "data"

    describe "#decrypt_body" do 
      it "should decrypt the body into xml" do 
        request = Twoctwop::Request.new(data)
        request.make_non_3ds_payment!
      end
    end
  end
end