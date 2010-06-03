class DFP::CompanyService < DFP::Service
  @client = Savon::Client.new("https://sandbox.google.com/apis/ads/publisher/v201004/OrderService?wsdl")
  
  TYPE_HOUSE_ADVERTISER = 'HOUSE_ADVERTISER'
  

end
