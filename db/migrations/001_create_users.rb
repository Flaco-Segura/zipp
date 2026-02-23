Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :first_name, null: false
      String :last_name, null: false
      String :email, null: false, unique: true, index: true
      String :type, null: false
      
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
