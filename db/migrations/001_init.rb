Sequel.migration do
  change do
    create_table(:urls) do
      primary_key :id
      String :url, null: false, index: true, unique: true
    end

    create_table(:regions) do
      primary_key :id
      String :index, null: false
      String :hash
      foreign_key :url_id, :urls

      index [:url_id, :index]
    end
  end
end
