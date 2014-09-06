require 'spec_helper'
require 'pry'

module Twoctwop
  describe Response do 
    include_context "data"

    let(:response_body) { File.read(File.join(Twoctwop.root, 'spec', 'fixtures', 'response_body.txt')) }

    let(:response_data) do 
      { 
        amt: "000000040000",
        approvalCode: "747505",
        dateTime: "060914155526",
        eci: "07",
        failReason: "Approved",
        hashValue: "12C6523EDAF49AE7D3189F98FC88709ACC0BC173",
        merchantID: "JT01",
        pan: "411111XXXXXX1111",
        refNumber: "0906110000041",
        respCode: "00",
        status: "A",
        timeStamp: "060914155630",
        tranRef: "M1000",
        uniqueTransactionCode: "M1000",
        userDefined1: nil,
        userDefined2: nil,
        userDefined3: nil,
        userDefined4: nil,
        userDefined5: nil, 
        version: "8.0"
      }
    end

    describe "#decrypt_body" do 
      it "should decrypt the body into xml" do 
        response = Twoctwop::Response.new(response_body)
        expect(response.decrypt_body).to eq Hashie::Mash.new(response_data)
      end
    end
  end
end