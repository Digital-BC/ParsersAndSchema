# frozen_string_literal: true

class Ubccontentdm753Ss4parser < SupplejackCommon::Json::Base

  
	  #a subset  of UBCcontentDM73_3 (it's too big otherwise)
	  
		#amsFTO.json
		#bcbooksFTO.json
		#bcsessionalFTO.json
		#catblend.json
		#chungphotosFTO.json
		#fishermanFTO.json
		#wwiphotoFTO.json

	  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/CONTENTDM/ubccontentdm75_3Subset4.json"
	  
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
	
	   /.*Image.*/ => "Image",
     /.*image.*/ => "Image",
    /.*TextLeg.*/ => "Other",
    /.*Newspapers.*/ => "Newspaper",
    "TextBooks" => "Book",
    "TextCorrespondence" => "Other",
    "TextBroadsides"  => "Other",
    "TextPamphlets"  => "Other",
    "TextAnnual reports"  => "Other",
    "TextTravel literature"  => "Other",
    "TextPeriodicals" => "Journal",
		"TextAddresses"  => "Other",
		"TextDictionaries"  => "Other",
		"TextCity directories"  => "Other",
		"TextBiographies"  => "Other",
		"TextGuidebooks" => "Book",
		"TextManuals (Handbooks)"  => "Book",
		"TextTranslations"  => "Other",
		"TextDirectories"  => "Other",
		"TextDiaries"  => "Other",
		"TextEthnography"  => "Other",
		"TextRegulations"  => "Other",
    "TextMaps"  => "Image",
		"TextBibliographies"  => "Other",
		"TextAdvertisements"  => "Other",
		"TextAlbums"  => "Other",
		"TextEssays"  => "Other",
		"TextLeaflets"  => "Other",
    "TextNovels"  => "Book",
		"TextPoetry"  => "Other",
		"TextPrograms"  => "Other",
		"Newspaper" => "Newspaper",
		"TextEncyclopedias"  => "Book",
		"TextAlmanacs"  => "Book",
    "TextCatalogs"  => "Book",
		"TextPhotographs"  => "Image",
		"TextProspectuses"  => "Other",
		"TextIllustrations"  => "Image",
		"TextOfficial gazettes"  => "Newspaper",
   	"TextTreaties"  => "Other",
		"TextClippings"  => "Newspaper",
		"TextEphemera"  => "Other",
		"TextGlossaries"  => "Other",
		"TextNarratives"  => "Other",
		"TextTrial proceedings"  => "Other",
		"Books"  => "Book",
		"TextAccount books"  => "Other",
		"TextAtlases (Geographic)"  => "Book",
    "TextCharters"  => "Other",
		"TextHudson's Bay Company"  => "Other",
		"TextIndexes"  => "Other",
		"TextManuscripts"  => "Other",
		"TextPhrase books"  => "Other",
    "TextPilot guides"  => "Other",
		"TextPrayer books"  => "Book",
		"TextRecord-keeping works"  => "Other",
		"TextVoting registers"  => "Other",
		"TextVoyages around the world"  => "Other",
		"textBook" => "Other"
      
      
      
	
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
	  #  thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with(/.*1.0115966.*/).present?
	    thumbnail_url
	  
	  
	    end
	  
	 
  #reject the broken DOI record
   	reject_if do
		     get(:thumbnail_url).find_with("https://open.library.ubc.ca/img/thumbnails/cdm/bcbooks/200/1.0366208").present?
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