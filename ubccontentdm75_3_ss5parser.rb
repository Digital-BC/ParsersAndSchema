# frozen_string_literal: true

class Ubccontentdm753Ss5parser < SupplejackCommon::Json::Base

  
  
  
	  
	  
	  
	    
	  #a subset  of UBCcontentDM73_3 (it's too big otherwise)
	  
		#chungtextFTO.json
		#tairikunippFTO.json
		#ubysseynewsFTO.json
	  
	 
	  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/CONTENTDM/ubccontentdm75_3Subset5.json"
	  
	  record_selector "$."
	  
	  attribute :partner, default: "University of British Columbia"
	 
	  
	  #some of the papers don't list a collection in the collection field, it's in series instead
	  
	  
	 # attribute :display_collection, path: "$.Series[0]['@value']"
	  
	#  attribute :series_display_collection, path: "$.Series[0]['@value']", mappings: {
	  #  /^/ => /\s\|/
	
	 #   }
	
	 
	  
	#  attribute :display_collection do
	#  compose(get(:pre_display_collection), get(:series_display_collection)).mapping(
	    
	#    /^\s\|/ => ""
	#)
	#end
	  
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
	  
	  
	  
	  attribute :category do
	  compose(get(:type),get(:genre)).mapping(
	
		/.*Clippings.*/ => "Newspaper",
		/.*Books.*/ => "Book",
		/.*Legal works.*/ => "Other",
		/.*Diaries.*/ => "Other",
		/.*Albums.*/ => "Other",
		/.*Image.*/ => "Image",
		/.*Record-keeping works.*/ => "Other",
		/.*Ephemera.*/ => "Other",
		/.*Correspondence.*/ => "Other",
		/.*Newspapers.*/ => "Newspaper",
		/.*Blank forms.*/ => "Other",
		/.*Certificates.*/ => "Other",
		/.*Menus.*/ => "Image",
		/.*Maps.*/ => "Image",
		/.*Igniting Accessory.*/ => "Other",
      
      
      
     /.*Postcards.*/ => "Image",
		/.*Invitations.*/ => "Other",
		/.*Directories.*/ => "Other",
		/.*Contracts.*/ => "Other",
		/.*Commemorative works.*/ => "Other",
		/.*Programs.*/ => "Other",
		/.*Regulations.*/ => "Other",
		/.*Exercise books (Penmanship).*/ => "Other",
		/.*Logs.*/ => "Other",
		/.*Guidebooks.*/ => "Other",
		/.*Paintings.*/ => "Image",
		/.*Periodicals.*/ => "Journal",
		/.*Architecture.*/ => "Other",
		/.*Illustrated works.*/ => "Image",
		/.*Emigrant guides.*/ => "Other",
		/.*Manuscripts.*/ => "Other",
		/.*Narratives.*/ => "Other",
		/.*Passenger lists.*/ => "Other",
		/.*Legal instruments.*/ => "Other",
		/.*Legal petition.*/ => "Other",
		/.*Drawings.*/ => "Image",
		/.*Legislative proceedings.*/ => "Other",
		/.*Photographs.*/ => "Image",
		/.*Xenophobic literature.*/ => "Other",
		/.*Petitions.*/ => "Other",
		/.*Affidavits.*/ => "Other",
		/.*Games.*/ => "Other",
		/.*Annual reports.*/ => "Other",
		/.*Keepsakes.*/ => "Other",
		/.*Protest literature.*/ => "Other",
		/.*Price lists.*/ => "Other",
		/.*Schedules.*/ => "Other",
		/.*Addresses.*/ => "Other",
		/.*Bag.*/ => "Other",
      
      
      
    /.*Catalogs.*/ => "Other",
		/.*Toilet Article.*/ => "Other",
		/.*Posters.*/ => "Image",
		/.*Newsletters.*/ => "Newspaper",
		/.*Itineraries.*/ => "Other",
		/.*Souvenir programs.*/ => "Other",
		/.*Eulogies.*/ => "Other",
		/.*Hand Luggage.*/ => "Other",
		/.*Food Preparation and Consumption.*/ => "Other",
		/.*Manuals (Handbooks).*/ => "Book",
      
      
    /.*Handbooks.*/ => "Book",
		/.*Yearbooks.*/ => "Book",
		/.*Notebooks.*/ => "Book",
		/.*Account books.*/ => "Other",
		/.*Official gazettes.*/ => "Newspaper",
      
      
    /.*Pamphlets.*/ => "Other",
		/.*Calendars.*/ => "Other",
		/.*Scores.*/  => "Other",
    /.*Pamphlets.*/ => "Other",

		/.*Song sheets.*/ => "Score",
		/.*Indexes.*/ => "Other",
		/.*Broadsides.*/ => "Newspaper",
      
    "TextBiographies" => "Other",
		"TextCampaign literature" => "Other",
		"TextExercise books (Penmanship)" => "Book",
    "TextExploration literature" => "Book",
    "TextAdvertisements" => "Other"  
	
	  )
	end
	
	
	 
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
	  
	  
	  attribute :thumbnail_url_builder, path: "$.DigitalResourceOriginalRecord[0]['@value']", mappings: {
	   "https://open.library.ubc.ca/collections/" => "https://open.library.ubc.ca/img/thumbnails/", 
	    /thumbnails.*/ => "thumbnails/cdm/",
	
	    } 
	  
	
	  #thumbnail url generator
	  attribute :pre_thumbnail_url do
	    first_th = get(:thumbnail_url_builder)
	    second_th = get(:source_record2)
	    third_th = "/200/"
	    fourth_th = get(:source_record3)
	
	     compose(first_th,second_th,third_th,fourth_th)
	
	  end
	  
	  
	  
	    attribute :thumbnail_url do
	    thumbnail_url = get(:pre_thumbnail_url)
	    thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/audio.svg" if get(:category).find_with(/^Audio$/).present?
	    thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/video.svg" if get(:category).find_with(/^Video$/).present?
      
			thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:source_url).find_with(/.*1.013239.*/).present?
			thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:source_url).find_with(/.*1.0356994.*/).present?
			thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:source_url).find_with(/.*1.0313623.*/).present?
			thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:source_url).find_with(/.*1.0313832.*/).present?  
	  #  thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with(/.*1.0115966.*/).present?
	    thumbnail_url
	  
	  
	    end
	  
  
    #reject the 502 errored record 
   	reject_if do


			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/chungtext/200/1.0225094").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/chungtext/200/1.0225099").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/chungtext/200/1.0225185").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/chungtext/200/1.0225472").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/chungtext/200/1.0225486").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/chungtext/200/1.0225620").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/chungtext/200/1.0225638").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/chungtext/200/1.0226116").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/ubysseynews/200/1.0123601").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/ubysseynews/200/1.0123989").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/ubysseynews/200/1.0124080").present? or 
			get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/ubysseynews/200/1.0124426").present?  

	end	

  
  
  
  
	  
	
		#preview_image_url generator  
	  attribute :pre_preview_image_url do
	    first_th = get(:thumbnail_url_builder)
	    second_th = get(:source_record2)
	    third_th = "/400/"
	    fourth_th = get(:source_record3)
	
	     compose(first_th,second_th,third_th,fourth_th)
	
	  end
	
	  
	   attribute :preview_image_url do
	    preview_image_url = get(:pre_preview_image_url)
	    preview_image_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/audio.svg" if get(:category).find_with(/^Audio$/).present?
	    preview_image_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/video.svg" if get(:category).find_with(/^Video$/).present?
			preview_image_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:source_url).find_with(/.*1.013239.*/).present?
			preview_image_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:source_url).find_with(/.*1.0356994.*/).present?
			preview_image_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:source_url).find_with(/.*1.0313623.*/).present?
			preview_image_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:source_url).find_with(/.*1.0313832.*/).present? 	 
       	
       
       
       #	thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with(/.*1.0115966.*/).present?
	  	preview_image_url
	  
	    end
	  
	  
	  
	  
	  #end of thumbnail/preview image constructor
	  
	  
	  attributes :landing_url do
	    get(:source_url)
	  end
	  
	    attributes :internal_identifier do
	    get(:landing_url).downcase
	  end
	  
	  
end