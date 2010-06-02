class DFP::LineItemService < DFP::Service
  WSDL_ENDPOINT = "https://sandbox.google.com/apis/ads/publisher/v201004/LineItemService?wsdl"
  
  soap_method(:get_line_item, :response => DFP::LineItem) { |id| {:line_item_id => id} }
  soap_method(:get_line_items_by_statement, :response => DFP::LineItem) { |query| {:filterStatement => {:query => query}} }
  soap_method(:create_line_items, :to_array => 'line_items', :response => DFP::LineItem) { |line_items| line_items }
  soap_method(:update_line_item, :response => DFP::LineItem) { |line_item| {:line_item => line_item} }
  
  class << self
    def create_line_item(line_item); create_line_items([line_item]); end
  end
end
