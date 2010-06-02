class DFP::CompanyService < DFP::Service
  WSDL_ENDPOINT = "https://sandbox.google.com/apis/ads/publisher/v201004/CompanyService?wsdl"
  
  TYPE_HOUSE_ADVERTISER = 'HOUSE_ADVERTISER'
  
  class << self
    # company needs a :name and :type
    def create_companies(companies)
      # companies = companies.collect 
      soap_call(:create_companies, {
        :companies => {:name => 'Vodpod', :type => TYPE_HOUSE_ADVERTISER}
      })
    end
  end
end
