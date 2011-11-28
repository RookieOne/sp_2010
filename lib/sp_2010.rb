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
    @@HOST = nil
    @@USER = nil
    @@PASSWORD = nil
    
    def self.authorize(host, user, password)
      @@HOST = host
      @@USER = user
      @@PASSWORD = password
    end
    
    def self.get_files    
      uri = URI.parse(@@HOST)
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Propfind.new(uri.request_uri)
      req.basic_auth(@@USER, @@PASSWORD)
      
      res = http.request(req)
      
      FilesResponse.new(res)
    end
    
  end
end
