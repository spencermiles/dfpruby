class DFP::Order < DFP::Model
  soap_attr :advertiser_id
  soap_attr :creator_id
  soap_attr :currency_code
  soap_attr :end_date_time, :type => DateTime
  soap_attr :external_id
  soap_attr :id
  soap_attr :is_archived
  soap_attr :name
  soap_attr :notes
  soap_attr :start_date_time, :type => DateTime
  soap_attr :status
  soap_attr :total_budget
  soap_attr :total_clicks_delivered
  soap_attr :total_impressions_delivered
  soap_attr :trafficker_id
  soap_attr :unlimited_end_date_time
  
  def save
    DFP::OrderService.update_order(self.instance_variable_get('@attributes').to_hash)
  end
  
  class << self
    def find(id)
      DFP::OrderService.get_order(id)
    end
    
    def find_by_statement(statement)
      DFP::OrderService.get_orders_by_statement(statement)
    end
  end
end