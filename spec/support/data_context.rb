shared_context "data" do 
  let(:data) do
    {
      uniqueTransactionCode: "M1000",
      desc:                  "Polo Shirt",
      amt:                   "000000040000",
      currencyCode:          702,
      panBank:               "Siam Commercial Bank",
      panCountry:            "SG",
      cardHolderName:        "John Doe",
      encCardData:           "00acjp+7erduPfJ6Wvrhp0L27fXGaue2/MPK/MUZtjnXRzrfCUpvG1c6ALQkogrYhqYVUDs5TGPoadv4nRwb2k5I/N/euS0srxJA0ikI9oC4xlM0NdLzdERgOzJrcsVR+QpVljjH7/lZ+PIMxwVR0X1vw3HRFxDuMiRARS3bxmmug8k=U2FsdGVkX1+HhQz45KZR33KzurxLl7VfYLofayanY+BfnBJJcgOHhK0rjNXqw5Se"
    }
  end

  let(:response_data) do 
    { 
      amt:                   "000000040000",
      approvalCode:          "747505",
      dateTime:              "060914155526",
      eci:                   "07",
      failReason:            "Approved",
      hashValue:             "12C6523EDAF49AE7D3189F98FC88709ACC0BC173",
      merchantID:            "JT01",
      pan:                   "411111XXXXXX1111",
      refNumber:             "0906110000041",
      respCode:              "00",
      status:                "A",
      timeStamp:             "060914155630",
      tranRef:               "M1000",
      uniqueTransactionCode: "M1000",
      userDefined1:          nil,
      userDefined2:          nil,
      userDefined3:          nil,
      userDefined4:          nil,
      userDefined5:          nil, 
      version:               "8.0"
    }
  end
end