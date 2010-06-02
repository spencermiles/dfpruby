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
    self.to_s =~ /^wsdl\:/ ? self : "wsdl:#{self}".to_sym
  end
end

class Symbol
  def to_wsdl_keys
    self.to_s.to_wsdl_keys
  end
end