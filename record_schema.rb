
class RecordSchema
    include SupplejackApi::SupplejackSchema
    # Namespaces
    namespace :dc, url: 'http://purl.org/dc/elements/1.1/'
    namespace :sj,        url: ''
    # Fields
    string    :record_id, store: false
    string    :internal_identifier
    #string    :title,  search_boost: 10,  search_as: [:filter, :fulltext], namespace: :dc
    #boost mod - failure in solr (version?, my edits?)
    string    :title, search_as: [:filter, :fulltext], namespace: :dc
    #string    :description,  search_boost: 2,  search_as: [:filter, :fulltext],  namespace:   :dc
    string    :description, search_as: [:filter, :fulltext],  namespace:   :dc
    string    :display_collection,  search_as: [:filter, :fulltext],  namespace: :sj
    string    :category,  multi_value: true,  search_as: [:filter]
    string    :creator,  multi_value: true, search_as: [:filter, :fulltext], namespace: :dc 
    string    :display_date, namespace: :sj
    string    :publisher, search_as: [:filter], namespace: :dc
    string    :subject, multi_value: true, search_as: [:filter, :fulltext],  namespace: :dc
    string    :language, multi_value: true, search_as: [:filter], namespace: :dc
    string    :rights, search_as: [:filter], namespace: :dc
    string    :partner, search_as: [:filter, :fulltext], multi_value: true,  namespace: :dc
    string    :notes, namespace: :sj # supplementary context note at partner or collection level
    string    :statement_of_harm, namespace: :sj # Harmful content statement (link to source repo document, or DBC page?)
    string    :locations, multi_value: true
    string    :preview_image_url,namespace: :sj
    string    :full_image_url,namespace: :sj
    string    :thumbnail_url
    string    :source_url
    string    :landing_url
    string    :status
    datetime  :created_at, date_format: '%y/%d/%m'
  
  
    # Groups
  
    group :valid_set_fields do
      includes []
      fields []
    end
  
  
    group :sets do
      includes []
      fields []
    end
  
  
  
    group :default do
      fields [
        :record_id,
        :internal_identifier,
      
        :title,
        :creator,
        :description,
        :category,
        :partner,
        :display_collection,
        :subject,
        :display_date,
        :language,
        :rights,
        :publisher,
        :locations,
        :source_url,
        :landing_url,
        :preview_image_url,
        :full_image_url,
        :thumbnail_url,
        :status,
        :datetime,
        :notes,
        :statement_of_harm
      ]
    end
  
  
  
  
    # Roles
    role :developer, default: true
    role :admin, admin: true
    role :harvester, harvester: true
  
    model_field :index_updated, field_options: { type: Mongoid::Boolean }
    model_field :index_updated_at, field_options: { type: DateTime }
  end
  