module DFP
  class Service
    require 'rubygems'
    require 'savon'
    require 'oauth'
    
    # cattr_accessor :_client #, :auth_token
    
    class << self
      def client
        @@client ||= Savon::Client.new(self::WSDL_ENDPOINT)
      end
      
      def auth_token
        @@auth_token ||= DFP::OAuth.get_auth_token
      end
      
      def debugging=(val)
        # self.client.request.http.set_debug_output(val ? STDOUT : nil)
      end
    
      def soap_call(method, body = nil, &block)
        # self.client.request.http.set_debug_output(DFP::Config::DEBUGGING ? STDOUT : nil)
        
        self.client.send(method) do |soap|
          soap.header = request_header
          soap.namespaces['xmlns:xsd'] = 'http://www.w3.org/2001/XMLSchema'
          soap.namespaces['xmlns:xsi'] = 'http://www.w3.org/2001/XMLSchema-instance'
          soap.body = body
        
          yield soap if block
        end
      end
    
      def request_header
        {'wsdl:RequestHeader' =>
          {'wsdl:authToken' => auth_token, 'wsdl:applicationName' => 'vodpod.com'},
          :attributes! => {'wsdl:RequestHeader' => {'env:mustUnderstand' => '0', 'env:actor' => "http://schemas.xmlsoap.org/soap/actor/next"}}}
      end
      
      def soap_method(method, options = {}, &block)
        metaclass = (class << self; self; end)

        metaclass.class_eval do
          define_method(method) do |*args|
            value = yield(args[0])
            value = value.to_wsdl_keys if value.respond_to?(:to_wsdl_keys)
            
            # Convert the value to a SOAP array
            if array_name = options[:to_array] and value.is_a?(Array)
              value = value.to_soap_xml(array_name.to_wsdl_keys)
            end
            
            response = soap_call(method, value).to_hash
            response = response["#{method}_response".to_sym][:rval]
            response = response[:results] if response[:results]
            
            objectize_response(response, options[:response])
          end
        end
      end
      
      def objectize_response(response, response_klass)
        case response
        when Array
          response.collect {|i| response_klass.new(i)}
        when Hash
          response_klass.new(response)
        end
      end
      private :objectize_response
    end
  end
end

require 'lib/services/order_service'
require 'lib/services/user_service'
require 'lib/services/company_service'
