class UBCdspace310CollParser < SupplejackCommon::Json::Base
  
  
  
  
  #parses the  310 dspace collection: 

  #310FTO.json labelled as images . . but not images) all "Reasearch paper"

  
  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/DSPACE/310FTO.json"
  
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
  attribute :category, default: "Research paper"
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
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/date.svg" if get(:category).find_with(/^Data/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:category).find_with(/^Image/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/other.svg" if get(:category).find_with(/^Other/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:category).find_with(/^Research/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/book.svg" if get(:category).find_with(/^Book/).present?       
      thumbnail_url
  end
  
  
  
  
  
  
  
  attributes :landing_url do
    get(:source_url)
  end
  
    attributes :internal_identifier do
    get(:landing_url).downcase
  end
  
  
  

  
  
  
  
  

end