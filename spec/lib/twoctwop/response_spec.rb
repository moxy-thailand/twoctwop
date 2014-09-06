require 'spec_helper'
require 'pry'

module Twoctwop
  describe Response do 
    include_context "data"

    let(:response_body) { File.read(File.join(Twoctwop.root, 'spec', 'fixtures', 'response_body.txt')) }

    describe "#decrypt_body" do 
      it "should decrypt the body into xml" do 
        response = Twoctwop::Response.new(response_body)
        expect(response.decrypt_body).to eq Hashie::Mash.new(response_data)
      end
    end
  end
end