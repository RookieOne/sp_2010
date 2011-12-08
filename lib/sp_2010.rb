require "sp_2010/version"
require 'httparty'
require 'json'
require 'net/http'
require 'uri'
require 'file'
require 'nokogiri'
require 'ntlm/http'

module Sp2010
  class Client
    include HTTParty
    
    def self.get_files(options={})
      host = options[:host]
      domain = options[:domain]
      user = options[:user]
      password = options[:password]
      uri = URI.parse(host)
      http = Net::HTTP.new(uri.host, uri.port)
      
      if (use_ssl?(host))
        http.use_ssl = true
      end
      
      req = Net::HTTP::Propfind.new(uri.request_uri)
      
      if domain
        req.ntlm_auth(user, domain, password)
      else
        req.basic_auth(user, password)
      end
      
      res = http.request(req)
      
      FilesResponse.new(res)
    end
    
    def self.use_ssl?(host)
      x = URI.split(host)
      false if x.count == 0
      x[0] == "https"
    end
    
  end
  
  class FilesResponse
    attr :files, :error_message
    
    def initialize(response)      
      if response.code == "401"
        @error_message = "Unauthorized access. Check your username and password."
        @files = []
      elsif response.code == "207"
        @error_message = ""
        xml= ::Nokogiri::XML(response.body)
        @files = (xml).xpath("./D:multistatus/D:response").map {|node| File.new(node) }        
      end 
    end
    
    def valid?
      @error_message.empty?
    end
    
  end
end
