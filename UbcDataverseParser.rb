# frozen_string_literal: true

class UbcDataverseParser < SupplejackCommon::Json::Base

	
	  
	  
	  
	    

	  
		#researchdataDataverseFTONov4.json
	  
	 
	  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/DATAVERSE/researchdataDataverseFTONov4.json"
	  
	  record_selector "$."
	  
	  attribute :partner, default: "University of British Columbia"
	 
	  
	  attribute :series_display_collection, path: "$.Series[0]['@value']"
	  
	  attribute :collection_display_collection, path: "$.Collection[0]['@value']"
	  
		attribute :display_collection do
	  compose(get(:collection_display_collection),get(:series_display_collection))
		end
	
	  
	  
	  
	  
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
	   
	
	  attribute :type, path: "$.Type[0]['@value']"
	  attribute :genre, path: "$.Genre[0]['@value']"
	  
	  
	  
	  attribute :category, default: "Data"
	
	 
	  attribute :rights, path: "$.Rights[0]['@value']"
	  attribute :publisher, path: "$.Publisher[0]['@value']"    
	  attribute :creator, path: "$.Creator[0]['@value']" , mappings: { 
	    /, [0-9].*/ => ""
	    }
	  
	  
	  attribute :coverage, path: "$.GeographicLocation[0]['@value']"
	
	  attribute :source_url, path: "$.['@id']", mappings: {
	    /^/=> "https://dx.doi.org/"
	
	    } 
	  #broken DOIs 
	   #reject_if do
	
	
	
	
	
	  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421460").present? or
	  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421465").present? or
	  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421470").present? or
	  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421511").present? or
	  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421515").present? or
	  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421515").present? 
	     
	
	  # end
	  
	
	  
	  #start of thumbnail/preview image constructor
	  
	  
	  attribute :source_record, path: "$.DigitalResourceOriginalRecord[0]['@value']"
	#   reject_if do
	          
	     #dhim journals have moved to another platform
	  #   get(:source_record).find_with(/.*dhim.*/).present?
	    
	   # end
	
	
	  
	    attribute :source_record2 do
	      get(:source_record).split("/").select(4, :last).select(:first).downcase
	
	      end
	  
	  
	  attribute :source_record3 do
	      get(:source_record).split("/").select(6, :last).select(:first)
	
	      end
	  

	  
	    attribute :thumbnail_url, default: "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/data.svg"
	  
	  	attribute :preview_image_url, default: "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/data.svg"
	  

	  
	  attributes :landing_url do
	    get(:source_url)
	  end
	  
	    attributes :internal_identifier do
	    get(:landing_url).downcase
	  end
	  
	  
	
	  
	 

end