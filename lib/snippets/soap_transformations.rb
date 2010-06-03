class Hash
  def to_wsdl_keys
    Hash[*self.collect {|k,v| [k.to_wsdl_keys, v.is_a?(Hash) ? v.to_wsdl_keys : v]}.flatten]
  end
end

class Array
  def to_wsdl_keys
    self.collect {|v| v.respond_to?(:to_wsdl_keys) ? v.to_wsdl_keys : v}
  end
end

class String
  def to_wsdl_keys
    (self.to_s =~ /\:/ || self.to_s == 'attributes!' ) ? self.to_sym : "wsdl:#{self}".to_sym
  end
end

class Symbol
  def to_wsdl_keys
    self.to_s.to_wsdl_keys
  end
end

class DateTime
  def to_soap_value
    {:date => {:year => self.year, :month => self.month, :day => self.day}, :hour => self.hour, :minute => self.min, :second => self.sec}.to_wsdl_keys.to_soap_xml
  end
end