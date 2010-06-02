module DFP
  module OAuth
    class << self
      def get_consumer
        OAuth::Consumer.new('vodpod.com', 'yOcRLgTwbf4IlCjM1qO0u1HK',
          {:site => 'https://www.google.com',
           :request_token_path => '/accounts/OAuthGetRequestToken',
           :access_token_path => '/accounts/OAuthGetAccessToken',
           :authorize_path => '/accounts/OAuthAuthorizeToken'})
      end
    
      def get_request_token
        request = get_consumer.get_request_token( {}, {:scope => "https://www.google.com/apis/ads/publisher/"})
        # Go to request.authorize_url, this will give you a PIN
        # then access = request.get_access_token(:oauth_verifier => PIN)
        # access.token and access.secret
      end
    
      def get_auth_token
        http = Net::HTTP.new('www.google.com', 443)
        http.use_ssl = true
        resp, body = http.post('/accounts/ClientLogin', "accountType=GOOGLE&Email=#{DFP::Config::GOOGLE_EMAIL}&Passwd=#{DFP::Config::GOOGLE_PASSWORD}&service=gam")
        
        body.match(/Auth=(.+)$/)[1]
      end
    end
  end
end
