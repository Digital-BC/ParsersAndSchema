class Ubcdspace38parser < SupplejackCommon::Json::Base
  
  

  #parses 38 dspace collections: 
  
                #25332FTO.json
                #31776FTO.json
                #32457FTO.json
                #33381FTO.json
                #33426FTO.json
                #42446FTO.json
                #43377FTO.json
                #51833FTO.json
                #51869FTO.json
                #52657FTO.json
                #52660FTO.json
                #53032FTO.json
                #53169FTO.json
                #53926FTO.json
                #55474FTO.json
                #58233FTO.json
                #59368FTO.json
                #59369FTO.json
                #59370FTO.json
                #59374FTO.json
                #59404FTO.json
                #59405FTO.json
                #59406FTO.json
                #59585FTO.json
                #60499FTO.json
                #62152FTO.json
                #63300FTO.json
                #641FTO.json
                #67246FTO.json
                #67247FTO.json
                #67634FTO.json
                #67656FTO.json
                #70440FTO.json
                #73804FTO.json
                #75346FTO.json
                #76471FTO.json
                #77752FTO.json
                #81709FTO.json
  
  
  base_url "https://praeclusio.nyc3.digitaloceanspaces.com/ParserData/UBC/DSPACE/UBCdspace38.json"
  
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
 

    
  
  attribute :precategory1 do
    fetch("$.Type[*]['@value']")#.select(:last)
  end
  
    attribute :precategory2 do
      fetch("$.Genre[*]['@value']")#.select(:last)
  end
  
  
  
  attribute :categoryCombined do compose(get(:precategory1), "|", get(:precategory2))
end
  

    
  attribute :category do get(:categoryCombined).mapping(


      "Text|Other" => "Other",
      "Text|Report" => "Other",
      "Text|Presentation" => "Other",
      "Moving Image" => "Video",
      "Text|Conference Paper"  =>  "Research paper",
      "Text|Book"  =>  "Book",
      "DatasetStill ImageText|Other" => "Data",
      "Other|" => "Other",
      "Sound|" => "Audio",
      "Video|" => "Video",
      "Text|Article"  =>  "Research paper",
      "Still ImageVideo|" => "Image",
      "Dataset|" => "Data",
      "VideoAudio|" => "Video",
      "TextVideo|Presentation" => "Video",
      "VideoText|Presentation" => "Video",   
      "Text|Thesis/Dissertation" => "Research paper",
      "TextAudio|Other" => "Audio",
      "Text|" =>"Other",
      "Text|Poster" => "Image",
      "VideoStill Image|" => "Video",
      "AudioVideo|" => "Video",
      "TextAudio|Presentation" => "Audio",
      "Still Image|" => "Image",
      "DatasetSoftware|"  => "Data",
      "TextStill Image|Poster" => "Image",
      "Text|PresentationOther" => "Other",
      "TextDatasetSoftware|Other" => "Data",
      "TextVideo|" => "Video",
      "DatasetOther|" => "Data",
      "DatasetText|Other"  => "Data",
      "OtherSoftware|" => "Other",
      "VideoSoftware|" => "Other",
      "TextVideo|PresentationOther" => "Video",
      "Text|ReportOther"  => "Research paper",
      "DatasetVideo|" => "Data",
      "TextDataset|" => "Data", 
      "TextAudio|" => "Audio",
      "TextAudio" => "Audio",
      "Text|Working Paper"  =>  "Research paper",
      "VideoText|Other" => "Video",
      "TextDataset|Other" => "Data",
      "TextDatasetOther|Other" => "Data",
      "TextOther|" => "Other",
      "TextStill ImageAudio|Presentation" => "Image",
      "TextStill Image|Other" => "Image",
      "TextInteractive ResourceVideo|Thesis/Dissertation"  =>  "Research paper",
      "TextVideo|Other" => "Video",
      "TextStill Image|Presentation" => "Image",
      "Text|Book Chapter"  =>  "Book",
      "Still ImageAudio|" => "Audio",
      "Text|PosterOther" => "Image",
      "VideoAudio" => "Video",
      "TextDataOther" => "Data",
      "Still ImageVideo" => "Image",
      "TextVideoPresentation" => "Video",
      "OtherPoster" => "Image",
      "OtherWorking Paper" => "Research paper",
      "TextInteractive ResourceVideoThesis/Dissertation" => "Video",
      "TextAudioOther" => "Audio",
      "Still ImageAudio" => "Audio",
      "SoundVideo" => "Audio",  
      "Book Chapter" => "Book",
      "TextImagePresentation" => "Image",
      "TextStill ImageAudioPresentation" => "Audio",
      "TextImageOther" => "Image",
      "TextDatasetOtherOther" => "Data",
      "TextData" => "Data",
      "TexAudio" => "Audio",
      "OtherOther" => "Other",
      "DatasetOther" => "Data",
      "TextImagePoster" => "Image",
      "TextAudioPresentation" => "Audio",
    
      "AudioOther" => "Audio",
      "AudioPresentation" => "Audio",
      "TextVideo" => "Video",
      "DatasetStill ImageOther" => "Data",
      "DatasetVideo" => "Data",
      "ImageOther" => "Image",
      "TextOther" => "Other",
      /VideoOther+$/ => "Video"

    
    
    
    
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
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/data.svg" if get(:category).find_with(/^Data/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/image.svg" if get(:category).find_with(/^Image/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/other.svg" if get(:category).find_with(/^Other/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg" if get(:category).find_with(/^Research/).present?
      thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/book.svg" if get(:category).find_with(/^Book/).present?  

      
    #thumbnail_url = "https://viurrspace.ca/bitstream/handle/10613/26017/Hoffe.pdf.jpg"  if get(:source_url).find_with("https://viurrspace.ca/handle/10613/26017").present?      
    thumbnail_url
  end
  
  
  
  
  
  
  
  attributes :landing_url do
    get(:source_url)
  end
  
    attributes :internal_identifier do
    get(:landing_url).downcase
  end
  
  
  
  
  
  
  

end