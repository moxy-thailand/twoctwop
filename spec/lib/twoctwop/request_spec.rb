require 'spec_helper'

module Twoctwop
  describe Request do 
    let(:data) do
      {
        uniqueTransactionCode: "M1000",
        desc:                  "Polo Shirt",
        amt:                   "0000000040000",
        currencyCode:          764,
        panBank:               "Siam Commercial Bank",
        panCountry:            "TH",
        cardHolderName:        "Zack Siri",
        encCardInfo:           "encrypted card data"
      }
    end

    let(:built_request) { File.read(File.join(Twoctwop.root, 'spec', 'fixtures', 'built_request.txt')) }

    describe "#build_request" do 
      let(:request) { Twoctwop::Request.new(data) }

      it "should merge data hash with essential data" do 
        expect(request.send(:build_request)).to eq built_request
      end
    end
  end
end