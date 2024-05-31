class VIRLDCparser < SupplejackCommon::Xml::Base
  
  
  
  base_url "https://praeclusio.nyc3.digitaloceanspaces.com/ParserData/DenmanAndVIRL/VIRLDCsept13s.xml"
  
  namespaces dc:"http://purl.org/dc/elements/1.1/"
  
  record_selector "//record" 
  record_format :xml
  attributes :partner, default: "Vancouver Island Regional Library"
  attributes :title, xpath: "//dc:title"
  attributes :creator, xpath: "//dc:creator"
  attributes :category, default: "Audio"
  attributes :publisher, xpath: "//dc:publisher"   
  attribute :description, xpath: "//dc:description", truncate: 170, mappings: {/https.*$/ => ''}
  #removes url from description field for newspapers
 attribute :display_date, xpath: "//dc:date"  do
   get(:display_date).select(:last).truncate(4, "")
end
  
  attribute :coverage, xpath: "//dc:coverage"
  attribute :language, xpath: "//dc:language" 
  attributes :rights, xpath: "//dc:rights" 
  attributes :subject, xpath: "//dc:subject"

  
  attribute :display_collection, default: "'Tell Us Your Story' Oral History Project"
  
 
  attribute :landing_url, xpath: "//identifier", mappings: {"oai:viurrspace.ca:" => "https://viurrspace.ca/handle/"}
  
  attributes :source_url do
   get(:landing_url)
  end
  
  attributes :internal_identifier do
   get(:landing_url).downcase
  end
  
  attribute :thumbnail_url, default: "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/audio.svg"
  
  
  
  # start of thumbnail enrichment ------------- 
  
  
  
#enrichment :get_thumbs, priority: -4, required_for_active_record: false do 
    
 #     requires :uri do
 #       primary[:source_url].first
 #   end
    
 #   url requirements[:uri]
 #   format :html
   
    
 #   attribute :thumbnail_url do
 # compose("https://viurrspace.ca", fetch("//div/img[@class='img-thumbnail']/@src"))
#end

#end
  
  
  
# end of thumbnail enrichment -------------    
  

  



  
 
  

  

end