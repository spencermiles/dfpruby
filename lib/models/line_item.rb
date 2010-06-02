class DFP::LineItem < DFP::Model
  soap_attr :order_id
  soap_attr :id
  soap_attr :name
  soap_attr :order_name
  soap_attr :start_date_time, :type => DateTime
  soap_attr :start_type
  soap_attr :end_date_time, :type => DateTime
  soap_attr :unlimited_end_date_time
  soap_attr :creative_rotation_type
  soap_attr :delivery_rate_type
  soap_attr :roadblocking_type
  soap_attr :frequency_caps
  soap_attr :line_item_type
  soap_attr :unit_type
  soap_attr :duration
  soap_attr :units_bought
  soap_attr :cost_per_unit
  soap_attr :value_cost_per_unit
  soap_attr :cost_type
  soap_attr :discount_type
  soap_attr :discount
  soap_attr :creative_sizes
  soap_attr :allow_overbook
  soap_attr :stats
  soap_attr :delivery_indicator
  soap_attr :delivery_data
  soap_attr :budget
  soap_attr :status
  soap_attr :reservation_status
  soap_attr :targeting
  
  def save
    DFP::LineItemService.update_line_item(self.instance_variable_get('@attributes').to_hash)
  end
  
  class << self
    def find(id)
      DFP::LineItemService.get_line_item(id)
    end
    
    def find_by_statement(statement)
      DFP::LineItemService.get_line_items_by_statement(statement)
    end
  end
end