class RRU2022metsParserProd2D7 < SupplejackCommon::Xml::Base

  
#base_url "https://praeclusio.nyc3.digitaloceanspaces.com/ParserData/RRUmetsSept7.xml"

  #new pull after oai mod 
#base_url "https://praeclusio.nyc3.digitaloceanspaces.com/ParserData/RRU/RRUmetsOct11.xml"
  
  # and post source file edits (research shorts thumbs and missing types) 
  
base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/RRU/RRUmets-Dec20-23forIcons.xml"
  
record_selector "//record" 
record_format :xml
  
namespaces mods:"http://www.loc.gov/mods/v3"
namespaces premis: "http://www.loc.gov/standards/premis"
namespaces mets: "http://www.loc.gov/METS/"
namespaces xlink: "http://www.w3.org/TR/xlink/"
  
validates :title, presence: true     
attributes :title, xpath: "//mods:title"
attributes :partner, default: "Royal Roads University"
attributes :creator, xpath: "//mods:namePart"
attributes :publisher, xpath: "//mods:publisher"   


  
  #set default category for where they are mising


attribute :pre_category, default: "Research paper"
attribute :type_category, xpath: "//mods:genre", mappings:{

    /.*Image.*/ => "Image",
    "Article" => "Journal",
    #x Image 107
    /.*Video.*/ => "Video",
    #
  /.*Book.*/ => "Research paper",
    "Plan or blueprint" => "Image",
    #Other 20
    "Thesis" => "Research paper",
    # Book 11
    "Technical Report" => "Other",
    # x Image, 3-D
    "Presentation" => "Other",
    "Preprint" => "Research paper",
    "Recording, musical" => "Audio",
    "Report" => "Other",
    "Working Paper" => "Research paper"
    
    }
  
  
  
  
  
  attribute :category do
    category = get(:pre_category)
    category = "Audio" if get(:type_category).find_with(/^Audio$/).present?
    category = "Video" if get(:type_category).find_with(/^Video$/).present?
    category = "Journal" if get(:type_category).find_with(/^Journal$/).present?
    category = "Image" if get(:type_category).find_with(/^Image$/).present?
    category = "Other" if get(:type_category).find_with(/^Other$/).present?
    category = "Research paper" if get(:type_category).find_with(/^Research paper$/).present?
    category
  
    end
  
  
    
  #attribute :category, default: ["Research paper"] do
   # get(:type_category) if get(:pre_category).present?
#end
  
  
  
  
  
    attribute :pre_display_collection do
    fetch("//setSpec")
end

  
  #reject the ResearchSorts and separate to fix thumbs nightmare

    reject_if do
    get(:pre_display_collection).find_with("col_10613_23111").present?
    end
  
  
  
  
 
  attribute :display_collection do get(:pre_display_collection).mapping(


#Archives
/.*_10170_90/ => "Archives | Film and Audio Clips",
/.*_10170_125/ => "Archives | Historic Architectural and Garden Plans",
/.*_10170_128/ => "Archives | Photographs, Documents and Slideshows",

/.*_10170_715/ => "College of Interdisciplinary Studies | Faculty Research | Belcher, Brian",
/.*_10170_906/ => "College of Interdisciplinary Studies | Faculty Research | Hodson, Jaigris",
/.*_10170_900/ => "College of Interdisciplinary Studies | Faculty Research | Jones, Shelley", 
    
    
    
   # /.*_10170_35/ => "Student Research Collection", 
/.*_10170_696/ => "Student Research | Doctoral Dissertations | Doctor of Social Sciences",
/.*_10170_606/ => "Student Research | Masters Theses |  MA Interdisciplinary Studies Theses",
/.*_10170_608/ => "Student Research | Showcase | MA Interdisciplinary Studies Major Projects",

/.*_10170_408/ => "Faculty Research Collection", 

/.*_10613_23112/ => "Open Educational Resources | Books",
/.*_10613_23111/ => "Open Educational Resources | Videos",

/.*_10170_544/ =>  "RRU Publications |  Meeting Minutes | Academic Council", 

/.*_10170_539/ => "RRMC Legacy Collection | Coastal Marine Science Laboratory Manuscript Reports",
/.*_10170_540/ => "RRMC Legacy Collection |  Royal Roads Military College Theses",

/.*_10613_5263/ => "RRMC Legacy Collection | Engaging Students in Life-Changing Learning",
/.*_10170_497/ => "RRMC Legacy Collection |  RRU Books and Reports",
/.*_10613_25304/ => "RRMC Legacy Collection | Socially Engaged Applied Doctoral Research in Canada: Approaches to Contemporary Social and Management Opportunities and Challenges",

/.*_10170_368/ => "School of Business | Student Research",

/.*_10170_152/ => "School of Communication and Culture | Faculty Research",
/.*_10170_609/ => "School of Communication and Culture | Student Research", 

/.*_10170_630/ => "School of Education and Technology | Student Research", 

/.*_10170_578/ => "School of Environment and Sustainability | Faculty Research",
/.*_10170_533/ => "School of Environment and Sustainability | Student Research", 
/.*_10170_505/ => "School of Environment and Sustainability |  Books and Reports",

/.*_10170_712/ => "School of Humanitarian Studies | Faculty Research",
/.*_10170_934/ => "School of Humanitarian Studies | Student Research",

/.*_10170_624/ => "School of Leadership Studies | Student Research Masters Theses MA Leadership",
/.*_10170_391/ => "School of Leadership Studies | Books and Reports",

/.*_10170_688/ => "School of Tourism and Hospitality | Student Research", 


/.*_10613_8613/ => "Showcase | Applied Interdisciplinarity in Scholar Practitioner Programs",
/.*_10613_6154/ => "Showcase | Edging Forward: Reconnection, Reconciliation, Regeneration",
/.*_10613_6256/ => "Showcase | Life Off Grid",
/.*_10613_23009/ => "Showcase | Pride in Research",
/.*_10613_12234/ => "Showcase | Public Ethnography as Innovative Learning",
/.*_10613_6265/ => "Showcase | Resilience by Design",
/.*_10613_23019/ => "Showcase | Sustainability Research Effectiveness",
/.*_10613_12533/ => "Showcase | Sustainable Communities: Making a Difference",
/.*_10613_6352/ => "Showcase |  The Land Remembers: Celebrating Indigenous Perspectives on Arts & Changing Landscapes",


/.*_10170_36/ => "Student Research Collection | Dissertations & Theses @ RRU",
/.*_10170_473/ => "Student Research Collection |Showcase", 


    #and then map out the extra collections com/col
/co.*/ => ""

)
  end
    
attribute :description, xpath: "//mods:abstract", truncate: 170, mappings: {/https.*$/ => ''}
#removes url from description field for newspapers
    

attribute :display_date, xpath: "//mods:dateIssued"  do
   get(:display_date).select(:last).truncate(4, "")
end
  
  
attribute :language, xpath: "//mods:languageTerm" 

attributes :rights, xpath: "//mods:accessCondition" 

attributes :subject, xpath: "//mods:topic"
  
attribute :landing_url, xpath: "//identifier", mappings: {"oai:viurrspace.ca:" => "https://viurrspace.ca/handle/"}

    reject_if do  #mising records
 
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4897").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4908").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4909").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4911").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4910").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4912").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4913").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4915").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4914").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4916").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4917").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4918").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4919").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4920").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4922").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4921").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4923").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4924").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4925").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4926").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4927").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4928").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4929").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4930").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4931").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4932").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4934").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4933").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4935").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4936").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4937").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4940").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4939").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4941").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4942").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4953").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4954").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/25850").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24513").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24477").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24378").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/25873").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24485").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24478").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24514").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/19904").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/23487").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24484").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/23311").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24483").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/17706").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4988").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4989").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/5034").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/5035").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/5043").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/5143").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/5495").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/5574").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/5575").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/5576").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/6562").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/6671").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7051").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7052").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7169").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7170").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7171").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7172").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7174").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7173").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7175").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7176").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7191").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7177").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7192").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7193").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7194").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7195").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7196").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7197").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/7198").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/10684").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/11368").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24509").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/25848").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/25879").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/24488").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/23081").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/25984").present? or 
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/26000").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4894").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/4894").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/26061").present? or
get(:landing_url).find_with("https://viurrspace.ca/handle/10613/26000").present? 


    end

  
attributes :source_url do
   get(:landing_url)
    end
  
attributes :internal_identifier do
    get(:landing_url).downcase
    end

  
  
  

  #=====================FULL for Dpsace 7==================  
  #attribute :full_image_url do 
  #  fetch('//*[@USE="ORIGINAL"]//*[@MIMETYPE="image/jpeg"]//@*[local-name()="href"]').select(:first)
  #  end
  


 
  #=====================THUMB for Dpsace 7==================
   
 # attribute :pre_thumbnail_url do 
 #   fetch('//*[@USE="TEXT"]//*[@MIMETYPE="image/jpeg"]//@*[local-name()="href"]').select(:first)
    
#end

 
  
  
  
attribute :thumbnail_url do
  thumbnail_url = get(:category)
    thumbnail_url = "https://praeclusio.nyc3.digitaloceanspaces.com/Icons/audio.svg" if get(:category).find_with(/^Audio$/).present?
    thumbnail_url = "https://praeclusio.nyc3.digitaloceanspaces.com/Icons/video.svg" if get(:category).find_with(/^Video$/).present?
    thumbnail_url = "https://praeclusio.nyc3.digitaloceanspaces.com/Icons/other.svg" if get(:category).find_with(/^Other$/).present?
    thumbnail_url = "https://praeclusio.nyc3.digitaloceanspaces.com/Icons/document.svg" if get(:category).find_with(/^Research paper$/).present?
    thumbnail_url = "https://praeclusio.nyc3.digitaloceanspaces.com/Icons/document.svg" if get(:category).find_with(/^Journal$/).present?
    thumbnail_url = "https://praeclusio.nyc3.digitaloceanspaces.com/Icons/image.svg" if get(:category).find_with(/^Image$/).present?
  thumbnail_url
  end
  
  
  

end