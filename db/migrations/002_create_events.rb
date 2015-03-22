Sequel.migration do
  change do
    create_table(:events) do
      primary_key :id

      String :url
      String :index
      String :hash_val
    end
  end
end
