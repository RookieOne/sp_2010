module Sp2010
  class FilesResponse
    attr :files, :error_message
    
    def initialize(response)      
      if response.code == "401"
        @error_message = "Unauthorized access. Check your username and password."
        @files = []
      elsif response.code == "207"
        @error_message = ""
        xml= Nokogiri::XML(response.body)
        @files = (xml).xpath("./D:multistatus/D:response").map {|node| File.new(node) }        
      end 
    end
    
    def valid?
      @error_message.empty?
    end
    
  end
end