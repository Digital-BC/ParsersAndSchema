  # start of thumbnail enrichment ------------- 
  
  
  
enrichment :get_thumbs, priority: -4, required_for_active_record: false do 
    
      requires :uri do
        primary[:source_url].first
    end
    
    url requirements[:uri]
    format :html
   
    
    attribute :thumbnail_url do
  compose("https://viurrspace.ca", fetch("//div/img[@class='img-thumbnail']/@src"))
end

end
  
  
  
# end of thumbnail enrichment -------------    
  