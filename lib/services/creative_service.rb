class DFP::CreativeService < DFP::Service
  @client = Savon::Client.new("https://sandbox.google.com/apis/ads/publisher/v201004/CreativeService?wsdl")
  
  soap_method(:get_creative, :response => DFP::Creative) { |id| {:creative_id => id} }
  soap_method(:get_creatives_by_statement, :response => DFP::Creative) { |query| {:filterStatement => {:query => query}} }
  soap_method({:create_creatives_third_party => :create_creatives}, :to_array => 'creatives', :to_array_attributes => {:'xsi:type' => 'wsdl:ThirdPartyCreative'}, :response => DFP::Creative) { |creatives| creatives }
  soap_method(:update_creative, :response => DFP::Creative) do |creative|
    { :creative => creative, :attributes! => {:'creative' => {:'xsi:type' => 'wsdl:ThirdPartyCreative'} }}
  end
  
  class << self
    # def create_creative(creative); create_creatives([creative]); end
    
    def create_creative_third_party(creative)
      create_creatives_third_party([creative])
    end
  end
end
