class Ubccontentdm752parser < SupplejackCommon::Json::Base
    
  
#advanceFTO.json
#alumchronFTO.json
#archivesavFTO.json
#ardeauFTO.json
#bchFTO.json
#berkpostFTO.json
#calendarsFTO.json
#capilanoFTO.json
#cassiarnewsFTO.json
#ccmsFTO.json
#chungobjectFTO.json
#chungosgrFTO.json
#chungpubFTO.json
#citraudioFTO.json
#courtenayrevFTO.json
#cranbrookproFTO.json
#cwnFTO.json
#delgamuukwFTO.json
#delttimeFTO.json
#dhimjournalFTO.json
#discorderFTO.json
#disledferFTO.json
#dorothyburnFTO.json
#epnohFTO.json
#etheljohnsFTO.json
#eveworossFTO.json
#expressnvFTO.json
#fernieledFTO.json
#fgheraldFTO.json
#florenceFTO.json
#goldeneraFTO.json
#gvchinookFTO.json
#hundredFTO.json
#ifcsmFTO.json
#jphotosFTO.json
#kinesisFTO.json
#kootstarFTO.json
#ladysmithstFTO.json
#mccormickFTO.json
#morninglnwFTO.json
#mpadvocateFTO.json
#nicoheralFTO.json
#ominecaFTO.json
#ominecaminerFTO.json
#paystreakFTO.json
#princeroFTO.json
#prismFTO.json
#proslillFTO.json
#qcislanderFTO.json
#silsilFTO.json
#simpsonFTO.json
#slodrillFTO.json
#specialpFTO.json
#squeezesFTO.json
#stravinskyFTO.json
#tgdpFTO.json
#the432FTO.json
#truthdFTO.json
#ubclsbFTO.json
#ubctpFTO.json
#vmaFTO.json
#wclarionFTO.json
#westlandFTO.json
#xalberniadvFTO.json
#xanacondaFTO.json
#xatlinFTO.json
#xbellacooFTO.json
#xcariboosenFTO.json
#xindependenFTO.json
#xminingrevFTO.json
#xnakledgeFTO.json
#xnelsoneconFTO.json
#xnicolaFTO.json
#xprospectorFTO.json
#xwestcallFTO.json
  
  
  
  
  
 
  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/CONTENTDM/ContentDM75_2FTOnov4.json"
  
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

    " (Geographic)" => "",
   /.*Book.*/ => "Book",
   /.*Moving Image.*/=>  "Video",
   /.*Sound.*/=>  "Audio",
   /.*Newspapers.*/=>  "Newspaper",
    /.*Still Image.*/=>  "Image",
    "TextAtlases" => "Book",
    "TextDrawings" => "Image",
    "TextMaps"  => "Image",
    "TextIllustrations" => "Image",
    "TextPosters" => "Image",
    "TextNotebooks" => "Book",
    "TextGuestbooks" => "Book",
    /.*Text.*/ => "Other"   
    )
end

  
  
#   attribute :category do
#   category = get(:pre_category)
#     category = "Book" if get(:type).find_with(/.*Books.*/).present?
#     category = "Book" if get(:type).find_with(/.*Book.*/).present?
#     category = "Image" if get(:type).find_with("Still Image").present?
#     category = "Video" if get(:type).find_with("Moving Image").present?
#     category = "Audio" if get(:type).find_with("Sound").present?   
#     category
  
#    end

 
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
  # reject_if do
     
  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0118725").present? or
  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421460").present? or
  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421465").present? or
  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421470").present? or
  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421511").present? or
  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421515").present? or
  #   get(:source_url).find_with("https://dx.doi.org/doi:10.14288/1.0421515").present? 
     

  #end
  

  
  #start of thumbnail/preview image constructor
  
  
  attribute :source_record, path: "$.DigitalResourceOriginalRecord[0]['@value']"
    

     reject_if do
            
       #dhim journals have moved to another platform
       get(:source_record).find_with(/.*dhim.*/).present?
      
      end




 
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
  # thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:source_url).find_with(/.*1.0115966.*/).present?
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