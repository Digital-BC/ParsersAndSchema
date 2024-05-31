class Ubccontentdm751parser < SupplejackCommon::Json::Base

   
  
  
  
  #75 content DM collections

			#agassizFTO.json
			#andersonFTO.json
			#armstrongadFTO.json
			#bcnewsFTO.json
			#bcreportsFTO.json
			#bcretFTO.json
			#biblosFTO.json
			#bickleeFTO.json
			#bullockFTO.json
			#cascadeFTO.json
			#cflaclaFTO.json
			#cgFTO.json
			#chasetribFTO.json
			#childrenlitFTO.json
			#chilliwackfpFTO.json
			#chockonFTO.json
			#creelmanFTO.json
			#darwinFTO.json
			#davidsoniaFTO.json
			#dayteleFTO.json
			#deltnewsFTO.json
			#eastkootmineFTO.json
			#ecrosbyFTO.json
			#eveningtFTO.json
			#feedersFTO.json
			#focusFTO.json
			#framedFTO.json
			#gfminerFTO.json
			#goldentimesFTO.json
			#greemineFTO.json
			#griFTO.json
			#hawthornFTO.json
			#hollandFTO.json
			#htimesFTO.json
			#indworldFTO.json
			#instrccFTO.json
			#kamishibaiFTO.json
			#kccaFTO.json
			#kerechroFTO.json
			#kwawaFTO.json
			#ladysmithlFTO.json
			#lardeaumFTO.json
			#ledgeFTO.json
			#ledgefernFTO.json
			#libsenrepFTO.json
			#lilladvaFTO.json
			#loktinFTO.json
			#manuscriptsFTO.json
			#mathisonFTO.json
			#meiji150FTO.json
			#nanacourFTO.json
			#nanamailFTO.json
			#newestimesFTO.json
			#normankwongFTO.json
			#ohsFTO.json
			#paccannwFTO.json
			#pedestalFTO.json
			#penpressFTO.json
			#pmgazetteFTO.json
			#presrepFTO.json
			#redflagFTO.json
			#rosettiFTO.json
			#sagaFTO.json
			#sgazetteFTO.json
			#smreviewFTO.json
			#thenuggetFTO.json
			#touchpointsFTO.json
			#ubcavfrcFTO.json
			#ubclibnewsFTO.json
			#ubcstuhanFTO.json
			#ubcyearbFTO.json
			#vanbuildrecFTO.json
			#wwpostersFTO.json
			#xhotspringsFTO.json
			#ymirheraldFTO.json
  
 
  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/CONTENTDM/ContentDM75_1Nov4.json"
  
  record_selector "$."
  
  attribute :partner, default: "University of British Columbia"
 
  
  #some of the papers don't list a collection in the collection field, it's in series instead
  
  
  attribute :display_collection, path: "$.Collection[0]['@value']"
  
#  attribute :series_display_collection, path: "$.Series[0]['@value']", mappings: {
  #  /^/ => /\s\|/

 #   }

 
  
#  attribute :display_collection do
#  compose(get(:pre_display_collection), get(:series_display_collection)).mapping(
    
#    /^\s\|/ => ""
#)
#end
  
  
  
  
  
  
  
  
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
   
  

  #attribute :cat1, path: "$.Genre[0]['@value']"
  #attribute :cat2, path: "$.Type[0]['@value']"
  
  
  #mapping
  
  
    attribute :pre_category, path: "$.Genre[0]['@value']", mappings: {
  
				"Newspapers" =>"Newspaper",
				"Photographs" => "Image",
				# "Periodicals" 
				"Addresses"  => "Other",
				"Correspondence"  => "Other",
				"Maps"  => "Image",
				"Illustrations"  => "Image",
				"Ephemera"  => "Other",
				"Account books"  => "Other",
				"Notebooks"  => "Other",
				"Record-keeping works"  => "Other",
				"Paintings"  => "Image",
				"Drawings"  => "Image",
				"Albums"  => "Book",
				"Chapbooks"  => "Book",
				"Spellers"  => "Other",
				"Catechisms"  => "Other",
				"Books"  => "Book",
				"Certificates"  => "Other",
				"Leaflets" => "Newspaper",
				"Diaries"  => "Book",
				"Transcriptions"  => "Other",
				"Essays"  => "Other",
				"Feeding Bottle"  => "Image",
				"Spouted Bowl"  => "Image",
				"Heating Stand"  => "Image",
				"Cylindrical Mug"  => "Image",
				"Cutlery"  => "Image",
				"Pump"  => "Image",
				"Rattle"  => "Image",
				"Poetry"  => "Other",
				"Prints" => "Image",
				"Miscellaneous Documents" => "Other",
				"Portraits" => "Image",
				"Architecture" => "Image",
				"Landscapes"  => "Image",
				"Military registers"  => "Other",
				"Posters"  => "Image",
				"Proclamations"  => "Other",
				"Menus"  => "Image",
				"Pamphlets"  => "Book",
      	"Interviews" => "Other",
				"Jacket"  => "Image",
				"Scrapbooks"  => "Book",
				"Fishing surveys"  => "Other",
				"Plays"  => "Other",
				"Memorial works"  => "Other",
				"Manuscripts"  => "Other",
				"Blank forms"  => "Other",
				"Advertisements"  => "Other",
				"Broadsides"  => "Other",
				"Programs"  => "Other",
				"Timetables"  => "Other",
				"Manuals (Handbooks)"  => "Book",
				"Autobiographies"  => "Other",
				"Memoirs"  => "Other"
             

    }

  

  

  
  #address periodicals label (we don't have a periodical/magazine label)

   #address periodicals label (we don't have a periodical/magazine label)

  attribute :type, path: "$.Type[0]['@value']"
  
   attribute :category do
   category = get(:pre_category)
     category = "Image" if get(:type).find_with("Still Image").present?
     category = "Video" if get(:type).find_with("Moving Image").present?
     category = "Audio" if get(:type).find_with("Sound").present?
     
     category = "Newspaper" if get(:title).find_with("Biblos").present?
     category = "Journal" if get(:title).find_with("Creative giving").present?
     category = "Journal" if get(:title).find_with("British Columbia Reports").present?
		 category = "Journal" if get(:title).find_with("British Columbia Law Reports").present?
		 category = "Journal" if get(:title).find_with("Digest of British Columbia case law").present?
     
     category = "Journal" if get(:title).find_with("Davidsonia").present?
     category = "Journal" if get(:title).find_with("Focus").present?
     category = "Other" if get(:title).find_with(/Report of the University Librarian.*/).present?
     category = "Newspaper" if get(:title).find_with("UBC Library News").present?
     

     category = "Book" if get(:title).find_with(/[Ss]tudent [Hh]andbook/).present?
     category = "Other" if get(:title).find_with(/.*Tillicum.*/).present?
     category = "Other" if get(:title).find_with("AMS Insider").present?
     
		 category = "Journal" if get(:title).find_with("Okanagan History").present?
     category = "Other" if get(:title).find_with(/President's Report.*/).present?
     category = "Other" if get(:title).find_with(/Report of the President of the University of British Columbia .*/).present? 
     category = "Journal" if get(:title).find_with("Touchpoints").present?
     category = "Journal" if get(:title).find_with("Nursing Today").present? 
     category = "Other" if get(:title).find_with(/.*Totem.*/).present?
     
     category = "Journal" if get(:title).find_with("Innovations").present?
     category = "Other" if get(:title).find_with(/.*Report of The Library.*/).present?
     category = "Other" if get(:title).find_with(/.*Librarian's Report to the Senate.*/).present?
     category = "Other" if get(:title).find_with(/.*Senate Report.*/).present?
     category = "Journal" if get(:title).find_with(/.*report of the Okanagan Historical.*/).present?
     category = "Other" if get(:title).find_with(/.*Annual Report.*/).present?
     category = "Book" if get(:title).find_with("Exercise Book").present?
     category = "Book" if get(:title).find_with("Sketches of Hudson Bay life by H. Bullock Webster 1874-1880").present?
     
     
     category = "Other" if get(:title).find_with(/.*Report of the President.*/).present?
     category = "Other" if get(:title).find_with(/.*Report of the Library.*/).present?
     category = "Other" if get(:title).find_with(/.*Report on the Library.*/).present?
     category = "Journal" if get(:title).find_with(/.*Tuum [Ee]st.*/).present?
     category = "Journal" if get(:title).find_with(/Insight.*/).present?
     category = "Journal" if get(:title).find_with(/Inside UBC.*/ ).present?
     
      category = "Other" if get(:title).find_with(/.*Annual of the University.*/).present?
      category = "Other" if get(:title).find_with("UBC Annual").present?
      category = "Other" if get(:title).find_with("McGill Annual").present?
     category = "Other" if get(:title).find_with("The McGill Annual").present?
      category = "Book" if get(:title).find_with("A Hand Book of the University of British Columbia").present?
      category = "Other" if get(:title).find_with(/.*Report on the University Library.*/).present?
      category = "Other" if get(:title).find_with(/.*Report of the Librarian to the Senate.*/).present?
      category = "Other" if get(:title).find_with(/.*Annual of The University of British.*/).present?
     
     
      category = "Journal" if get(:title).find_with(/.*Reprint of report numbers.*/).present?
     	category = "Other" if get(:title).find_with("The Ubyssey Graduation Issue").present?
      category = "Journal" if get(:title).find_with("Define a university").present?
      category = "Other" if get(:title).find_with(/.*Start: how to thread the academic maze.*/).present?
      category = "Other" if get(:title).find_with(/.*Report of the Librarian to the Senate.*/).present?
     	category = "Other" if get(:title).find_with("Insider").present?
     category = "Other" if get(:title).find_with("AMS Student Agenda").present?
     category = "Other" if get(:title).find_with("Lifesaver").present?
     
      category = "Journal" if get(:title).find_with("The 1917 Annual").present?
      category = "Journal" if get(:title).find_with("Totie").present?
      category = "Journal" if get(:title).find_with("Annual of McGill University College").present?
     category = "Journal" if get(:title).find_with("Toward the Pacific Century").present?

     
     category
  
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
   reject_if do
     
     get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0118725").present? or
     get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421460").present? or
     get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421465").present? or
     get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421470").present? or
     get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421511").present? or
     get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421515").present? or
     get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421515").present? 
     

  end
  

  
  #start of thumbnail/preview image constructor
  
  
  attribute :source_record, path: "$.DigitalResourceOriginalRecord[0]['@value']"
    

 
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
    thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with(/.*1.0115966.*/).present?
    thumbnail_url
  
  
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
  	thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with(/.*1.0115966.*/).present?
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