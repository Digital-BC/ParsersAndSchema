# frozen_string_literal: true

class DenmanDCParser < SupplejackCommon::Xml::Base

  
  
  
  base_url "https://praeclusio.nyc3.digitaloceanspaces.com/ParserData/DenmanAndVIRL/DenmanDCCorrAllsept28.xml"
  
  #Rag and Bone update

  #base_url "https://praeclusio.nyc3.digitaloceanspaces.com/ParserData/DenmanAndVIRL/DenmanDCsept28RagAndBone.xml"
  
  namespaces dc:"http://purl.org/dc/elements/1.1/"
  
  record_selector "//record" 
  record_format :xml
  attributes :partner, default: "Denman Island Museum and Archives"
  attributes :title, xpath: "//dc:title"
  attributes :creator, xpath: "//dc:creator"
  attributes :category, default: "Newspaper"
  attributes :publisher, xpath: "//dc:publisher"   
  attribute :description, xpath: "//dc:description", truncate: 170, mappings: {/https.*$/ => ''}
  #removes url from description field for newspapers
 attribute :display_date, xpath: "//dc:date"  do
   get(:display_date).select(:last).truncate(4, "")
end
  
  attribute :coverage, xpath: "//dc:coverage"
  attribute :language, xpath: "//dc:language" 
  attributes :rights, xpath: "//dc:rights" 
 # attributes :subject, xpath: "//dc:subject"

 
  
  attribute :display_collection, xpath: "//setSpec", mappings:{

    
    #mapping out the communities . . .VIUspace/SpecColl,Denman . . .
  "com_10613_3277" => "",
  "com_10613_24" => "",    
  "com_10613_25744" => "",   
  "com_10613_25745" => "",    
    
  "col_10613_25798" => "Denman Island Serial Publications | Denman Island Newsletter",
  "col_10613_25766" => "Denman Island Serial Publications | Denman Islander / Island Life / Denman Island",
  "col_10613_25903" => "Denman Island Serial Publications | High Tides",
  "col_10613_25859" => "Denman Island Serial Publications | Tideline",
  "col_10613_26024" => "Denman Island Serial Publications | Rag and Bone"
      
      } 
  
 
  
  attribute :landing_url, xpath: "//identifier", mappings: {"oai:viurrspace.ca:" => "https://viurrspace.ca/handle/"}
  
  attributes :source_url do
   get(:landing_url)
  end
  
  attributes :internal_identifier do
   get(:landing_url).downcase
  end
  

  # start of thumbnail enrichment ------------- 
  #fixes 'sticky' fragment - overwriting enrichment with corrected images 
  
  
enrichment :get_thumbs, priority: -4, required_for_active_record: false do 
    
      requires :uri do
        primary[:source_url].first
    end
    
    url requirements[:uri]
    format :html
   
    
    attribute :pre_thumbnail_url do
  compose("https://viurrspace.ca", fetch("//div/img[@class='img-thumbnail']/@src"))
end

end
  
  
  
# end of thumbnail enrichment -------------    
  




    attribute :thumbnail_url do 
    fetch('//setSpec').mapping(
      
  "col_10613_25798" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/DIN.jpg",
  "col_10613_25766" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/IL.jpg",
  "col_10613_25903" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/HT.jpg",
  "col_10613_25859" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/Tide.jpg",
  "col_10613_26024" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/RnB.jpg",
  "com_10613_3277" => "",
  "com_10613_24" => "",    
  "com_10613_25744" => "",   
  "com_10613_25745" => ""
    )
    end
  
   attribute :preview_image_url do 
   fetch('//setSpec').mapping(
      
  "col_10613_25798" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/DIN_p.jpg",
  "col_10613_25766" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/IL_p.jpg",
  "col_10613_25903" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/HT_p.jpg",
  "col_10613_25859" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/Tide_p.jpg",
  "col_10613_26024" => "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/VIUthumbs/RnB_p.jpg",
  "com_10613_3277" => "",
  "com_10613_24" => "",    
  "com_10613_25744" => "",   
  "com_10613_25745" => ""
    )
    end
  
  


  
  
  
  
end