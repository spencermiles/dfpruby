class DFP::UserService < DFP::Service
  WSDL_ENDPOINT = "https://sandbox.google.com/apis/ads/publisher/v201004/UserService?wsdl"
  
  ROLE_SALESPERSON = -5
  ROLE_ADMINISTRATOR = -1
  ROLE_TRAFFICKER = -7
  ROLE_EXECUTIVE = -3
  ROLE_ADVERTISER = -2
  ROLE_SALES = -4
  
  soap_method(:get_user) { |user_id| {:userId => user_id} }
  
  class << self
    def create_users(params)
      soap_call(:create_users, {
        'wsdl:users' => {'wsdl:name' => 'Advertiser', 'wsdl:email' => 'spencermiles@gmail.com', 'wsdl:roleId' => ROLE_ADVERTISER, 'wsdl:preferredLocale' => 'en_US'}
      })
    end
  end
end
