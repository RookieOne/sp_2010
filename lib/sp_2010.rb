require "sp_2010/version"
require 'httparty'
require 'json'
require 'net/http'
require 'uri'
require 'net/dav'
require 'file'
require 'files_response'

module Sp2010
  class Client
    include HTTParty
    
    def self.get_files(host, user, password)
      uri = URI.parse(host)
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Propfind.new(uri.request_uri)
      req.basic_auth(user, password)
      
      res = http.request(req)
      
      FilesResponse.new(res)
    end
    
  end
end
