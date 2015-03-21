Sequel.migration do
  change do
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
    
    create_table(:urls, :ignore_index_errors=>true) do
      primary_key :id
      String :url, :size=>255, :null=>false
      
      index [:url]
    end
    
    create_table(:regions, :ignore_index_errors=>true) do
      primary_key :id
      String :index, :size=>255, :null=>false
      String :hash, :size=>255
      foreign_key :url_id, :urls
      
      index [:url_id, :index]
    end
  end
end
