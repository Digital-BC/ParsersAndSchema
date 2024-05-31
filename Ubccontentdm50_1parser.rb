class Ubccontentdm501parser < SupplejackCommon::Json::Base
  
  
 
  
  
  #50 content DM collectios

            #artefactsFTO.json
            #bclnFTO.json
            #bclumberFTO.json
            #bctFTO.json
            #bctuFTO.json
            #beaverdellFTO.json
            #bensunFTO.json
            #brooklynnewsFTO.json
            #citizennwFTO.json
            #coasmineFTO.json
            #columbiarevFTO.json
            #croftongazFTO.json
            #despatchFTO.json
            #djcoxFTO.json
            #enterpriseFTO.json
            #fraseradvancFTO.json
            #gcdbFTO.json
            #glennewsFTO.json
            #hqueekFTO.json
            #ielFTO.json
            #jscFTO.json
            #laborstarFTO.json
            #leaderaFTO.json
            #ledgenelFTO.json
            #loclaFTO.json
            #louieFTO.json
            #marytribFTO.json
            #michelrFTO.json
            #misscityFTO.json
            #mmentionFTO.json
            #mminerFTO.json
            #norcoaFTO.json
            #nursingFTO.json
            #nwminerFTO.json
            #omrFTO.json
            #peloyalistFTO.json
            #prossrossFTO.json
            #satworldFTO.json
            #slocanpFTO.json
            #surreytimesFTO.json
            #thesunFTO.json
            #ubchistFTO.json
            #ubcmedicineFTO.json
            #upubmiscFTO.json
            #vancouverwFTO.json
            #vslpFTO.json
            #wahshunFTO.json
            #westhoFTO.json
            #xmassettFTO.json
            #ymirmirrorFTO.json

  
  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/UBC/CONTENTDM/ubcContentDM50-1-Nov.4.json"
  
  record_selector "$."
  
  attribute :partner, default: "University of British Columbia"
 
  
  #some of the papers don't list a collection in the collection field, it's in series instead
  
  
  attribute :pre_display_collection, path: "$.Collection[0]['@value']"
 
  attribute :series_display_collection, path: "$.Series[0]['@value']"
  
  attribute :display_collection do
  compose(get(:pre_display_collection), get(:series_display_collection))
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
   
  

  #attribute :cat1, path: "$.Genre[0]['@value']"
  #attribute :cat2, path: "$.Type[0]['@value']"
  
  
  #mapping
  
  
  
  
  attribute :pre_category, path: "$.Genre[0]['@value']", mappings: {
  
     "Papyrus" => "Other",
      "Cuneiform inscriptions" => "Other",
      "Newspapers" => "Newspaper",
      "Album" => "Book",
      "Interviews" => "Other",
      "Periodicals" => "Other",
      "Illustrated works" => "Image",
      "Manuscripts" => "Book",
      "Books" => "Book",
      "Correspondence" => "Other",
      "Photographs" => "Image",
      "Pamphlets" => "Book",
      "Commemorative works" => "Other",
      "Clippings" => "Newspaper",
      "Ephemera" => "Other",
      "Postcards" => "Image",
      "Contracts" => "Other",
      "Account books" => "Other"
             

    }

  

  
  #address periodicals label (we don't have a periodical/magazine label)


  
   attribute :category do
   category = get(:pre_category)
     category = "Newspaper" if get(:title).find_with("Public health nurses' bulletin").present?
     category = "Journal" if get(:title).find_with("UBC Medicine").present?
     category = "Newspaper" if get(:title).find_with("Indian education newsletter").present?

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