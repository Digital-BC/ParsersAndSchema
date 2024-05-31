class Ubccontentdm17parser < SupplejackCommon::Json::Base
  
  
  
  #17 papers from the Historical Newspaper Collection (a test)

			#arlaadvoFTO.json
			#canfordFTO.json
			#coalmontFTO.json
			#cwhustlerFTO.json
			#echoFTO.json
			#evenkootFTO.json
			#htbvaFTO.json
			#koolibFTO.json
			#ladysmithrFTO.json
			#ladysmithsiFTO.json
			#qcminerFTO.json
			#sfjcbceFTO.json
			#slorecFTO.json
			#thestarFTO.json
			#thewaveFTO.json
			#vanadFTO.json
			#ymirminerFTO.json
  

  
  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/CONTENTDM/contentDM17FTONov4.json"
  
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
   
  

  attribute :category, default: "Newspaper"
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
  


  
  #start of thumbnail/preview image constructor
  
  
  attribute :source_record, path: "$.DigitalResourceOriginalRecord[0]['@value']"
    

 
    attribute :source_record2 do
      get(:source_record).split("/").select(4, :last).select(:first)

      end
  
  
  attribute :source_record3 do
      get(:source_record).split("/").select(6, :last).select(:first)

      end
  
  
  attribute :thumbnail_url_builder, path: "$.DigitalResourceOriginalRecord[0]['@value']", mappings: {
   "https://open.library.ubc.ca/collections/" => "https://open.library.ubc.ca/img/thumbnails/", 
    /thumbnails.*/ => "thumbnails/cdm/",

    } 
  

  #thumbnail url generator
  	attribute :thumbnail_url do
    first_th = get(:thumbnail_url_builder)
    second_th = get(:source_record2)
    third_th = "/200/"
    fourth_th = get(:source_record3)

     compose(first_th,second_th,third_th,fourth_th)

  end

	#preview_image_url generator  
    attribute :preview_image_url do
    first_th = get(:thumbnail_url_builder)
    second_th = get(:source_record2)
    third_th = "/400/"
    fourth_th = get(:source_record3)

     compose(first_th,second_th,third_th,fourth_th)

  end

  
  
  
  
  
  #end of thumbnail/preview image constructor
  
  
  attributes :landing_url do
    get(:source_url)
  end
  
    attributes :internal_identifier do
    get(:landing_url).downcase
  end
  
  
  

  
  
  
 
  

end