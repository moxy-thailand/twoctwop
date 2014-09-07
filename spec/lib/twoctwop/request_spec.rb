require 'spec_helper'

module Twoctwop
  describe Request do 
    include_context "data"

    let(:built_request_no_token)  { File.read(File.join(Twoctwop.root, 'spec', 'fixtures', 'built_request_no_token.txt')) }
    let(:built_request_with_card) { File.read(File.join(Twoctwop.root, 'spec', 'fixtures', 'built_request_with_card.txt')) }

    describe "#build_request" do 
      let(:request) { Twoctwop::Request.new(data: data) }

      it "should merge data hash with essential data" do 
        expect(request.send(:build_request)).to eq built_request_no_token
      end
    end

    describe "#build_request with token" do 
      let(:request) { Twoctwop::Request.new(data: data, token: 'blah') }

      it "should merge data with token" do 
        expect(request.send(:build_request)).to eq built_request_with_card
      end
    end
  end
end