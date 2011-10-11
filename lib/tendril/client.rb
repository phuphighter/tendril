module Tendril
  
  class Client    
    include HTTParty
    
    attr_reader :email, :password, :account_id, :subdomain
                
    def initialize(options={})
      @subdomain = options[:subdomain] || Tendril.subdomain
      @email = options[:email] || Tendril.email
      @password = options[:password] || Tendril.password
      @account_id = options[:account_id] || Tendril.account_id            
      
      self.class.base_uri "https://#{@subdomain}.tendrildemo.com/api/rest"
      self.class.headers 'Accept' => 'application/json', 
                         'Emsauthtoken' => "#{@email}:#{@password}"
    end

    def pricing(secondary, options={})
      mashup(self.class.get("/pricing/#{secondary}#{hash_to_querystring(options)}"))
    end

    def meter(secondary, options={})              
      mashup(self.class.get("/meter/#{secondary}#{hash_to_querystring(options)}"))
    end
    
    protected    
    
    def hash_to_querystring(hash)
      hash.keys.inject('') do |query_string, key|
        query_string << ';'
        
        if key.to_s == "from" || key.to_s == "to"
          value = tendril_convert_time(hash[key].to_s)
          query_string << "#{URI.encode(key.to_s)}=#{URI.encode(value)}"
        else
          query_string << "#{URI.encode(key.to_s)}=#{URI.encode(hash[key])}"
        end
      end
    end
    
    def tendril_convert_time(time)
      Time.parse(time).strftime("%Y-%m-%dT%H:%M:%S%z")
      # time.gsub(/((\d+-){2}\d+)(\s+)((\d+:){2}\d+)(\s+)(\S+)/, '\1'+'T'+'\4\7')
    end
    
    def mashup(response)
      case response.code
      when 200
        if response.is_a?(Hash)
          Hashie::Mash.new(response)
        else
          if response.first.is_a?(Hash)
            response.map{|item| Hashie::Mash.new(item)}
          else
            response
          end
        end
      end
    end
    
  end
end
