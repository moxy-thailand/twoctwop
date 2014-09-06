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

    let(:built_request) do
      "<PaymentRequest><uniqueTransactionCode>M1000</uniqueTransactionCode><desc>Polo Shirt</desc><amt>0000000040000</amt><currencyCode>764</currencyCode><panBank>Siam Commercial Bank</panBank><panCountry>TH</panCountry><cardHolderName>Zack Siri</cardHolderName><encCardInfo>encrypted card data</encCardInfo><version>8.0</version><merchantID>JT01</merchantID><hashValue>a17ed46e7082320644771fbb30a1160c3de41a10</hashValue></PaymentRequest>"
    end

    describe "#build_request" do 
      let(:request) { Twoctwop::Request.new(data) }

      it "should merge data hash with essential data" do 
        expect(request.send(:build_request)).to eq built_request
      end
    end
  end
end