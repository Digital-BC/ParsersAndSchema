# frozen_string_literal: true

class SQPL3parser < SupplejackCommon::Xml::Base

  base_url "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/ParserData/SQPL/SQPLMar19.xml"
  record_selector "//marcxml:record" 
  record_format :xml
  
  namespaces marcxml: "http://www.loc.gov/MARC21/slim"
  
  attributes :internal_identifier, xpath: "//marcxml:controlfield[@tag='001']", mappings: {
         /^/ => "https://openaccess.biblioboard.com/content/"  
  }
  

  
  attributes :partner, default: "Squamish Public Library"
  validates :title, presence: true 
  attributes :title, xpath: "//marcxml:datafield[@tag='245']/marcxml:subfield[@code='a']"
  attributes :creator, xpath: "//marcxml:datafield[@tag='245']/marcxml:subfield[@code='c']"
  attributes :description, xpath: "//marcxml:datafield[@tag='520']/marcxml:subfield[@code='a']", truncate: 170 
  attributes :publisher, xpath: "//marcxml:datafield[@tag='653']/marcxml:subfield[@code='b']"
  attributes :rights, default: "Fair Use"
  
  attribute :subject, xpath: "//marcxml:datafield[@tag='653']/marcxml:subfield[@code='a']" do
  get(:subject).to_a
  end

  attributes :display_date, xpath: "//marcxml:datafield[@tag='264']/marcxml:subfield[@code='c']", mappings: {
         "." => "",  
        "[nd]" => "",
        "[n.d.]" => "",
        "n.d." => ""
  }

  attributes :category1, xpath: "//marcxml:datafield[@tag='300']"
  attributes :category2, xpath: "//marcxml:datafield[@tag='336']"

  attribute :category3 do
  compose(get(:category1),get(:category2))
  end
    
  attribute :category4 do 
    get(:category3).mapping(
      
   /.*[iI]mage.*/ => "Image",
   /.*[aA]udio.*/ => "Audio",
   "Correspondence" => "Other",
   "Documents" => "Other",
   "Photographs" => "Image",
   "Leaflets" => "Other",  
   "Clippings" => "Newspaper",
   "Articles" => "Newspaper",  # in this case they are all newspapers
    "Invitations" => "Other",    
    /.*[mM]ap.*/ => "Image",
    /.*[pP]amphlet.*/ => "Other",
    "Programs" => "Other",
    "Sketch" => "Image",
    "legal" => "Other",  
    "Certificates" => "Other",
    "Pictures" => "Image",
    "Advertising cards" => "Other",
    "Bank notes" => "Other",
    "Books" => "Book",
    "Business cards" => "Other",
    "Charts" => "Image",
    "Circulars" => "Other",
    "Ledger Book" => "Other",
    "Newspapers" => "Newspaper",
    "Portrait photographs" => "Image",
    /.*[pP]oster.*/ => "Image",
    /.*business record.*/ => "Other", 
    "Proposed works" => "Other",
    "1 online resource.text txt rdacontent" => "Other",
    "1 online resource (unknown)text txt rdacontent" => "Other",
      ":" => ""   
      
    
      
     )
  end
  
   attributes :paper_handler, xpath: "//marcxml:datafield[@tag='264']/marcxml:subfield[@code='b']", mappings: {
         "." => "",
          "," => "", 
        "[sn]" => "",
        "[s.n.]" => "",
        "s.n." => ""
  }
  
   attribute :category do
    category = get(:category4)
    category = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/audio.svg" if get(:category).find_with(/.*[aA]udio.*/).present?
    category = "Newspaper" if get(:title).find_with(/.*(?i)newspaper.*/).present?
    category = "Newspaper" if get(:paper_handler).find_with(/.*Squamish Review.*/).present?
    category = "Newspaper" if get(:paper_handler).find_with(/.*Squamish Advance.*/).present?
    category = "Newspaper" if get(:paper_handler).find_with(/.*Squamish Progress.*/).present?
    category = "Newspaper" if get(:paper_handler).find_with(/.*Squamish Times.*/).present?
   
    category = "Other" if get(:title).find_with(/.*Letter.*/).present?
    category = "Image" if get(:title).find_with(/.*Photo.*/).present?
    category = "Image" if get(:title).find_with(/.*Map.*/).present?
    category = "Image" if get(:title).find_with(/.*Sketch.*/).present?
     
    category
 end
  
  
  attributes :source_url do
    get(:internal_identifier).downcase
  end
  
  attributes :landing_url do
    get(:source_url).downcase
  end
    
  
  
    #=====================THUMB CONSTRUCTOR==================
  
  attribute :pre_thumbnail_url, xpath: "//marcxml:datafield[@tag='029']/marcxml:subfield[@code='a']"
    #get(:landing_url).mapping(
     
   # "https://openaccess.biblioboard.com/content/" => "https://library.biblioboard.com/ext/api/media/", 
   #     /$/ => "/assets/thumbnail.jpg"
   #  )
   # end

  attribute :thumbnail_url do
    thumbnail_url = get(:pre_thumbnail_url)
    thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/audio.svg" if get(:category).find_with(/^Audio$/).present?
    thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/video.svg" if get(:category).find_with(/^Video$/).present?
    thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg"  if get(:category).find_with(/^Research paper$/).present? 
    thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/document.svg"  if get(:category).find_with(/^Journal$/).present? 
    thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/book.svg"  if get(:category).find_with(/^Book.*/).present? 
    thumbnail_url = "https://praeclusio.nyc3.cdn.digitaloceanspaces.com/Icons/other.svg"  if get(:category).find_with(/^Other$/).present? 
  thumbnail_url
 end
  
  #NO PREVIEW IMAGE


  
  
  
  
  
  
end