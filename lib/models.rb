module DFP
  class Model
    def initialize(params = {})
      update_attributes!(params)
    end
    
    def update_attributes!(params = {})
      params.each do |k,v|
        if respond_to?("#{k}=")
          send("#{k}=", v)
        end
      end
    end
    
    def new?
      self.id.nil?
    end
    
    def to_hash
      Hash[*self.instance_variables.collect {|var| [var.gsub('@', '').to_sym.to_soap_key, instance_variable_get(var)] }.flatten]
    end
    
    def save
      if new?
        response = self.class.get_service.send("create_#{self.class.noun.lower_camelcase}", self.instance_variable_get('@attributes').to_hash)
        update_attributes!(response.attributes)
      else
        self.class.get_service.send("update_#{self.class.noun.lower_camelcase}", self.instance_variable_get('@attributes').to_hash)
      end
    end
    
    class << self
      def noun
        self.name.gsub(/^\w+\:\:/, '')
      end
      
      def get_service
        DFP.const_get("#{noun}Service")
      end
      
      def find(id)
        get_service.send("get_#{noun.lower_camelcase}", id)
      end
      
      def find_by_statement(statement)
        get_service.send("get_#{noun.lower_camelcase}s_by_statement", statement)
      end
      
      def attribute_types
        @@attribute_types ||= {}        
      end
      
      def soap_attr(name, options = {})
        define_method(:attributes) do
          @attributes ||= {}
        end unless method_defined?(:attributes)
        
        define_method(name) do
          attributes[name.to_sym]
        end
        
        define_method("#{name}=") do |val|
          if DFP::Model.attribute_types[name.to_sym] == DateTime and val.is_a?(Hash)
            val = DateTime.parse("#{val[:date][:month]}/#{val[:date][:day]}/#{val[:date][:year]} #{val[:hour]}:#{val[:minute]}:#{val[:second]} #{val[:time_zone_id]}")
          end

          attributes[name.to_sym] = val
        end

        if options[:type]
          DFP::Model.attribute_types[name.to_sym] = options[:type]
        end
      end
    end
  end
end

require 'lib/models/order'
require 'lib/models/line_item'
require 'lib/models/creative'