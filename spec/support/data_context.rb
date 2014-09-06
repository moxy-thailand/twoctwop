shared_context "data" do 
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
end