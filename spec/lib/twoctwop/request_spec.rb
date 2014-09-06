require 'spec_helper'

module Twoctwop
  describe Request do 
    include_context "data"

    let(:built_request) { File.read(File.join(Twoctwop.root, 'spec', 'fixtures', 'built_request.txt')) }

    describe "#build_request" do 
      let(:request) { Twoctwop::Request.new(data) }

      it "should merge data hash with essential data" do 
        expect(request.send(:build_request)).to eq built_request
      end
    end
  end
end