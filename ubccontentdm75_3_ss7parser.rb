# frozen_string_literal: true

class Ubccontentdm753Ss7parser < SupplejackCommon::Json::Base

	
	  
	  
	  
	    
	  #a subset  of UBCcontentDM73_3 (it's too big otherwise)
	  
				#neslondailyFTO.json
	  
	 
	  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/CONTENTDM/ubccontentdm75_3Subset7.json"
	  
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
	  
	  
	  
		attribute :category, default: "Newspaper"  
	
	
	 
	  attribute :rights, path: "$.Rights[0]['@value']"
	  attribute :publisher, path: "$.Publisher[0]['@value']"    
	  attribute :creator, path: "$.Creator[0]['@value']" , mappings: { 
	    /, [0-9].*/ => ""
	    }
	  
	  
	  attribute :coverage, path: "$.GeographicLocation[0]['@value']"
	
	  attribute :source_url, path: "$.['@id']", mappings: {
	    /^/=> "https://dx.doi.org/"
	
	    } 

	
	
	
	

	
	  
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
	  

			attribute :thumbnail_url, default: "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/UBCthumbs/NelsonDailyThumb.jpg"

  		
			attribute :preview_image_url, default: "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/UBCthumbs/NelsonDailyPreview.jpg"
	

	  
	  
	  
	  #end of thumbnail/preview image constructor
	  
	  
	  attributes :landing_url do
	    get(:source_url)
	  end
  
  
  	#broken DOIs  . . . 155 of them
	   reject_if do
  
       	get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0381060").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402769").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402771").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402770").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402778").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402784").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402788").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402818").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402821").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402840").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402846").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402849").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402853").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402861").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402865").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402867").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402873").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402875").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402876").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402881").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402886").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402889").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402896").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402910").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402915").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402917").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402920").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402921").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402954").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402961").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402962").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402969").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402972").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402978").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402985").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402990").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402994").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402998").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0402999").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403012").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403013").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403019").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403036").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403047").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403063").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403067").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403068").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403085").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403089").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403091").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403092").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403093").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403095").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416764").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416773").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416781").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416805").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416815").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416828").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416838").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416854").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416856").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416859").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416867").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416876").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416880").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416893").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416904").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416906").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416907").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416927").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416941").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416957").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416961").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0416993").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417007").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417009").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417026").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417035").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417036").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417056").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417058").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417074").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417101").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417103").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417107").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417109").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417134").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417144").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417164").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417169").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417210").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417237").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417596").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417597").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417609").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417618").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417651").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417654").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417662").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417663").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417672").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417687").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417689").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417714").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417718").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417730").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417754").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417779").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417782").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417800").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417827").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417863").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417869").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417940").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417944").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417953").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417955").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417965").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417966").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417969").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0417995").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418016").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418019").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418055").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418061").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418065").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418081").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418126").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418132").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418170").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418176").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418183").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418223").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418241").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418267").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418285").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418299").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418302").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418311").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418335").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418344").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418359").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418362").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0381095").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0381754").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0382272").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0382668").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0382926").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0383700").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0383899").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0386401").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0401678").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0403006").present? or
				get(:landing_url).find_with("https://dx.doi.org/doi:10.14288/1.0418811").present? 
       
       
     end
	  
	    attributes :internal_identifier do
	    get(:landing_url).downcase
	  end
	  
	  
	
	  
	 

end