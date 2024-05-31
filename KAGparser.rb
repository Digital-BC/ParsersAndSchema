class KAGparser < SupplejackCommon::Xml::Base

  
    
  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/KAG/PPSdata_testMay17mod.xml"
  
  record_selector "//export" 
  record_format :xml
  
  attributes :partner, default: "Kelowna Art Gallery"
    #use display_content_partner for Prod-2
  attributes :description, xpath: "//udf21", truncate: 170  



  attributes :creator, xpath: "//creator"  
  attributes :title, xpath: "//title"
  attribute :subject do
    fetch("//subjects").split(/\n/)
  end


 
  
  #------- start category constructor - most are images  
  attributes :pre_category, default: "Image"


  attributes :medium, xpath: "//medium"
    

  
  attribute :category do
  category = get(:pre_category)
  category = "Video" if get(:type).find_with("HD Video").present?
  category
    end

  
 #------- end category constructor 
  
  
  attributes :publisher, xpath: "//credit"
  attributes :display_date, xpath: "//date"
  
  #attributes :locations, xpath: "//field[@name='itemLatLong']"
  #attributes :language, xpath: "//field[@name='language']", mappings: {
  #  "eng" => "en"

   # } 
  
 

  #attribute :rights, xpath: "//field[@name='rightsCreativeCommons']", mappings: {
  #                          "by" => "CC-BY"
  #                        }
  
 
  #full image url = landing_url + "#gallery"  [no preview] 

  
  attribute :landing_url, xpath: "//ppid", mappings: {

    /^/ => "http://kelownaartgallery.pastperfectonline.com/webobject/"
    }

 
  
  attribute :source_url do get(:landing_url)
  end
   
  
  reject_if do
        
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/5669931E-64D6-4659-B169-595110301451").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/A6EDBDA3-1149-462F-9DD5-642547898660").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/2FD2ED1C-8C21-40AF-95AE-185963141937").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/17E8D314-AF4F-4A23-8AFD-661326704230").present? or 
    
    
    
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/28DB8054-0BFB-45D2-B8AB-220485920896").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/DD8A9EDD-4000-4F5F-BBF3-134954459821").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/696245EE-3B98-49AC-BF5C-685269221786").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/90684BC6-E947-42A7-B018-005277839330").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/D5FBF1BA-4683-44A3-AC40-760336925071").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/C38F4479-A494-4A7B-BB4C-312445057369").present? or





#broken links


    get(:title).find_with("Mountains Mountains").present? or
    get(:creator).find_with("Sharni Pootoogook").present? or
    get(:creator).find_with("Stephanie M. Smith").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/4B95C369-B660-49B1-8721-698346616856").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/02EA61F7-75D7-4C39-A89F-572452344414").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/4F165CB8-7BBD-46AF-96B9-320327345080").present? or
    get(:source_url).find_with("http://kelownaartgallery.pastperfectonline.com/webobject/6F456F98-56A7-4D67-9BF5-990346992728").present? 

  

    end
  
    
  
  
  
  
  
  
    # start of thumbnail enrichment ------------- 
  
  enrichment :get_thumbs, priority: -4, required_for_active_record: false do 
    
      requires :uri do
        primary[:source_url].first
    end
    
    url requirements[:uri]
    format :html
   

    
    attribute :thumbnail_url do fetch("//figure/img/@src")
    end

    
   
    
    
end
  

# end of thumbnail enrichment -------------    

  
  
  
  
  
  
  
  
  attributes :internal_identifier do
    get(:landing_url).downcase
      
  end
  
  
  
  
  



  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end