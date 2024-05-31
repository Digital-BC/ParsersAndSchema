class Ubcdspace1parser < SupplejackCommon::Json::Base

  #parses dspace items
  
  base_url "https://praeclusio.nyc3.digitaloceanspaces.com/ParserData/UBC/DSPACE/DspaceTestNov4.json"
  
  record_selector "$."
  
  attribute :partner, default: "University of British Columbia"
  attribute :display_collection, path: "$.Collection[0]['@value']"
  
  validates :title, presence: true    
  attribute :title , path: "$.Title[0]['@value']"
  
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
 

    
  
  attribute :precategory do
    fetch("$.Type[*]['@value']").select(:last)
  end


  
  attribute :category do get(:precategory).mapping(

   "Moving Image" =>  "Video",
   "Sound" =>  "Audio"
    
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
   # thumbnail_url = "https://viurrspace.ca/bitstream/handle/10613/26017/Hoffe.pdf.jpg"  if get(:source_url).find_with("https://viurrspace.ca/handle/10613/26017").present?      
    thumbnail_url
  end
  
  
  
  
  
  
  
  attributes :landing_url do
    get(:source_url)
  end
  
    attributes :internal_identifier do
    get(:landing_url).downcase
  end
  
  
  
  
  
  
  
    
  
  
  



end