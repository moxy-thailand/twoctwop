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

    let(:built_data) do
      {
        uniqueTransactionCode: "M1000",
        desc:                  "Polo Shirt",
        amt:                   "0000000040000",
        currencyCode:          764,
        panBank:               "Siam Commercial Bank",
        panCountry:            "TH",
        cardHolderName:        "Zack Siri",
        encCardInfo:           "encrypted card data",
        version:               "8.0", 
        merchantID:            "JT01",
        hashValue:             "a17ed46e7082320644771fbb30a1160c3de41a10"
      }
    end

    describe "#build_final_data" do 
      let(:request) { Twoctwop::Request.new(data) }

      it "should merge data hash with essential data" do 
        expect(
          request.send(:build_final_data)
        ).to eq built_data
      end
    end
  end
end