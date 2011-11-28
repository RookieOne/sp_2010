module Sp2010
  class File
    attr_reader :xml
    attr :name, :uri, :url, :path, :size, :is_folder, :is_aspx, :created_at, :updated_at, :etag
    
    def initialize(node)
      @xml = node
      
      @name = dav_prop_at("./DAV:displayname").content
      @url = @xml.at_xpath("./DAV:href", webdav_namespace).content
      @uri = URI.parse(URI.escape(@url))
      @path = Pathname.new URI.unescape uri.path
      
      @is_aspx = name[-5..-1] == ".aspx"
      
      length = dav_prop_at("./DAV:getcontentlength").content
      @size = length ? length.to_i : nil
      
      isFolder = dav_prop_at("./DAV:isFolder")
      @is_folder = isFolder ? isFolder.content == "t" : false
      
      c = dav_prop_at("./DAV:getetag").content
      @etag = c.match(/^['"](.*)['"]$/)[1]
      
      @updated_at = dav_prop_at("./DAV:getlastmodified").content
      @created_at = dav_prop_at("./DAV:creationdate").content
    end
    
    def webdav_namespace
      webdav_namespace = {"DAV" => "DAV:"}
    end
    
    def dav_prop_at(prop)      
      @xml.xpath("./DAV:propstat/DAV:prop", webdav_namespace).at_xpath(prop, webdav_namespace)
    end
    
  end
end
