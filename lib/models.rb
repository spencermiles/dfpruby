module DFP
  class Model
    def initialize(params = {})
      params.each do |k,v|
        if respond_to?("#{k}=")
          send("#{k}=", v)
        end
      end
    end
    
    def to_hash
      Hash[*self.instance_variables.collect {|var| [var.gsub('@', '').to_sym.to_soap_key, instance_variable_get(var)] }.flatten]
    end
    
    class << self
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
          if DFP::Model.attribute_types[name.to_sym] == DateTime
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

  require 'lib/models/order'
end