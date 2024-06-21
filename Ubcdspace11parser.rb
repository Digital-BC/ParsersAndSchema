class Ubcdspace11parser < SupplejackCommon::Json::Base


  #parses 11 dspace collections: 
      #12708FTO.json
      #18861FTO.json
      #310FTO.json  excluded (labelled as images . . but not images) harvest separately
  #run it with a different parser - UBCdspace310Coll
      #42591FTO.json
      #48630FTO.json
      #494FTO.json
      #52383FTO.json
      #52966FTO.json
      #59278FTO.json
      #59367FTO.json
      #66428FTO.json
      #67657FTO.json
  
  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/DSPACE/ubcdspace11.json"
  
  record_selector "$."
  
  attribute :partner, default: "University of British Columbia"
  attribute :display_collection, path: "$.Collection[0]['@value']"
  
  validates :title, presence: true    
  attribute :title , path: "$.Title[0]['@value']"
  
      reject_if do
        get(:title).find_with("Non-Exclusive Distribution License").present?
     
  end
  
  
  
  
  attribute :subject, path: "$.Subject[0]['@value']"
  
  
  attribute :description, path: "$.Description[0]['@value']", truncate: 170
  attribute :display_date, path: "$.SortDate[0]['@value']", mappings: {
    " AD" => ""

    }
 

  #converts languages to ISO language codes, and splits into individual literals
  attribute :language, path: "$.Language[0]['@value']", mappings: {
    "English" => "eng",
    "Latin" => "lat",
    "Wakashan languages" => "wak", 
    "Salishan languages" => "sal",
    "Chinook jargon" => "chn", 
    "Athapascan languages" => "ath",
    "Carrier" => "crx", 
    "Ntlakyapamuk" => "thp",
    "French" => "fre",
    "Spanish" => "spa",
    "Nootka" => "nuk",
    "Shuswap" => "shs",
    "Tsimshian" => "tsi",
    "Squawmish" => "squ",
    "Sechelt" => "sec",
    "Lillooet" => "lil",
    "Salish" => "sal",
    "Okanagan" => "oka",
    "Chinook" => "chn",
    "Stalo" => "hur",
    "German" => "ger",
    "Cree" => "cre",
    "Kwakiutl" => "kwk"
    } do
      get(:language).split(";")
    end
   
  
  attribute :display_collection, path: "$.Affiliation[0]['@value']"
 

    
  
  attribute :precategory1 do
    fetch("$.Type[*]['@value']")#.select(:last)
  end
  
    attribute :precategory2 do
      fetch("$.Genre[*]['@value']")#.select(:last)
  end
  
  
  
  attribute :categoryCombined do compose(get(:precategory1), "|", get(:precategory2))
end
  

    
  attribute :category do get(:categoryCombined).mapping(
    
    /.*Sound.*/ => "Audio",
    /.*Moving.*/ => "Video", 
    /.*Book.*/ => "Book",
    #/.*Still.*/ => "Image",
    /.*Data.*/ => "Data",
    #/.*Poster.*/ => "Image",
    /.[Pp]aper.*/ => "Research paper",
    /.[Pp]ost.*/ => "Research paper",
    "Text|Graduating Project" => "Research paper",
    /.*Other.*/ =>  "Other", 
    "Text|Presentation" => "Research paper", 
    "Conference" => "", 
    "Text|" => "",
    "Article" => "Research paper",
    "Articl" => "",
    "Report" => "Research paper",
    "Software"  =>  "Other",
    "Working" => "",
    "Preprint" => "",
    "Graduating Project" => "",
    "TextInteractive Resource|Graduating Project"  => "Research paper",
    "Text" => "",
    "Research paperResearch paper" => "Research paper",
    "Research paperWorkingResearch paper" => "Research paper",
    
   
    /Still Image\|+$/ => "Image",
    
    "Still Image|Presentation" => "Other",
    "Still Image|Research"  => "Research paper",
    "Still ImageResearch"  => "Research paper",
    "Other|" => "Other",
    "Graduating ProjecResearch paper"  => "Research paper",
    "Interactive Resource|" => "Other",
    "PresentatioResearch paper"  => "Research paper",
    "Research paper paper" => "Research paper"
   
    
      )
end
  
  
  
  
  
  

  attribute :rights, path: "$.Rights[0]['@value']"
  attribute :publisher, path: "$.Publisher[0]['@value']"    
  attribute :creator, path: "$.Creator[0]['@value']" , mappings: { 
    /, [0-9].*/ => ""
    }
  
  
  attribute :coverage, path: "$.GeographicLocation[0]['@value']"
  
  validates :source_url, presence: true
  attribute :source_url, path: "$.['@id']", mappings: {
    /^/=> "https://dx.doi.org/"

    } 
  

    
    attribute :thumbnail_url do

      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/audio.svg" if get(:category).find_with(/^Audio$/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/video.svg" if get(:category).find_with(/^Video$/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/data.svg" if get(:category).find_with(/^Data/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:category).find_with(/^Image/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/other.svg" if get(:category).find_with(/^Other/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:category).find_with(/^Research/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/book.svg" if get(:category).find_with(/^Book/).present?  
      

      
    # frozen_string_literal: true

class Ubcdspace11parser < SupplejackCommon::Json::Base
  
  
 
  #parses 11 dspace collections: 
      #12708FTO.json
      #18861FTO.json
      #310FTO.json  excluded (labelled as images . . but not images) harvest separately
  #run it with a different parser - UBCdspace310Coll
      #42591FTO.json
      #48630FTO.json
      #494FTO.json
      #52383FTO.json
      #52966FTO.json
      #59278FTO.json
      #59367FTO.json
      #66428FTO.json
      #67657FTO.json
  
  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/DSPACE/ubcdspace11.json"
  
  record_selector "$."
  
  attribute :partner, default: "University of British Columbia"
  attribute :display_collection, path: "$.Collection[0]['@value']"
  
  validates :title, presence: true    
  attribute :title , path: "$.Title[0]['@value']"
  
      reject_if do
        get(:title).find_with("Non-Exclusive Distribution License").present?
     
  end
  
  
  
  
  attribute :subject, path: "$.Subject[0]['@value']"
  
  
  attribute :description, path: "$.Description[0]['@value']", truncate: 170
  attribute :display_date, path: "$.SortDate[0]['@value']", mappings: {
    " AD" => ""

    }
 

  #converts languages to ISO language codes, and splits into individual literals
  attribute :language, path: "$.Language[0]['@value']", mappings: {
    "English" => "eng",
    "Latin" => "lat",
    "Wakashan languages" => "wak", 
    "Salishan languages" => "sal",
    "Chinook jargon" => "chn", 
    "Athapascan languages" => "ath",
    "Carrier" => "crx", 
    "Ntlakyapamuk" => "thp",
    "French" => "fre",
    "Spanish" => "spa",
    "Nootka" => "nuk",
    "Shuswap" => "shs",
    "Tsimshian" => "tsi",
    "Squawmish" => "squ",
    "Sechelt" => "sec",
    "Lillooet" => "lil",
    "Salish" => "sal",
    "Okanagan" => "oka",
    "Chinook" => "chn",
    "Stalo" => "hur",
    "German" => "ger",
    "Cree" => "cre",
    "Kwakiutl" => "kwk"
    } do
      get(:language).split(";")
    end
   
  
  attribute :display_collection, path: "$.Affiliation[0]['@value']"
 

    
  
  attribute :precategory1 do
    fetch("$.Type[*]['@value']")#.select(:last)
  end
  
    attribute :precategory2 do
      fetch("$.Genre[*]['@value']")#.select(:last)
  end
  
  
  
  attribute :categoryCombined do compose(get(:precategory1), "|", get(:precategory2))
end
  

    
  attribute :category do get(:categoryCombined).mapping(
    
    /.*Sound.*/ => "Audio",
    /.*Moving.*/ => "Video", 
    /.*Book.*/ => "Book",
    #/.*Still.*/ => "Image",
    /.*Data.*/ => "Data",
    #/.*Poster.*/ => "Image",
    /.[Pp]aper.*/ => "Research paper",
    /.[Pp]ost.*/ => "Research paper",
    "Text|Graduating Project" => "Research paper",
    /.*Other.*/ =>  "Other", 
    "Text|Presentation" => "Research paper", 
    "Conference" => "", 
    "Text|" => "",
    "Article" => "Research paper",
    "Articl" => "",
    "Report" => "Research paper",
    "Software"  =>  "Other",
    "Working" => "",
    "Preprint" => "",
    "Graduating Project" => "",
    "TextInteractive Resource|Graduating Project"  => "Research paper",
    "Text" => "",
    "Research paperResearch paper" => "Research paper",
    "Research paperWorkingResearch paper" => "Research paper",
    
   
    /Still Image\|+$/ => "Image",
    
    "Still Image|Presentation" => "Other",
    "Still Image|Research"  => "Research paper",
    "Still ImageResearch"  => "Research paper",
    "Other|" => "Other",
    "Graduating ProjecResearch paper"  => "Research paper",
    "Interactive Resource|" => "Other",
    "PresentatioResearch paper"  => "Research paper",
    "Research paper paper" => "Research paper"
   
    
      )
end
  
  
  
  
  
  

  attribute :rights, path: "$.Rights[0]['@value']"
  attribute :publisher, path: "$.Publisher[0]['@value']"    
  attribute :creator, path: "$.Creator[0]['@value']" , mappings: { 
    /, [0-9].*/ => ""
    }
  
  
  attribute :coverage, path: "$.GeographicLocation[0]['@value']"
  
  validates :source_url, presence: true
  attribute :source_url, path: "$.['@id']", mappings: {
    /^/=> "https://dx.doi.org/"

    } 
  

    
    attribute :thumbnail_url do

      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/audio.svg" if get(:category).find_with(/^Audio$/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/video.svg" if get(:category).find_with(/^Video$/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/data.svg" if get(:category).find_with(/^Data/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:category).find_with(/^Image/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/other.svg" if get(:category).find_with(/^Other/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:category).find_with(/^Research/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/book.svg" if get(:category).find_with(/^Book/).present?  
      
      #missing thumbs
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0107460").present?
			thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0379515").present?
			thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0395129").present?
			thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0395445").present?   
      thumbnail_url
  end
  
  
  
  
  
  
  
  attributes :landing_url do
    get(:source_url)
  end
  
    attributes :internal_identifier do
    get(:landing_url).downcase
  end
  
  
  

end
    thumbnail_url
  end
  
  
  
  
  
  
  
  attributes :landing_url do
    get(:source_url)
  end
  
    attributes :internal_identifier do
    get(:landing_url).downcase
  end
  
  
  

  
  
  
end
