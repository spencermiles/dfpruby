class DFP::OrderService < DFP::Service
  WSDL_ENDPOINT = "https://sandbox.google.com/apis/ads/publisher/v201004/OrderService?wsdl"
  
  soap_method(:get_order, :response => DFP::Order) { |id| {:orderId => id} }
  soap_method(:get_orders_by_statement, :response => DFP::Order) { |query| {:filterStatement => {:query => query}} }
  soap_method(:create_orders, :to_array => 'orders', :response => DFP::Order) { |orders| orders }
  soap_method(:update_order, :response => DFP::Order) { |order| {:order => order} }
  
  class << self
    def create_order(order); create_orders([order]); end
  end
end
