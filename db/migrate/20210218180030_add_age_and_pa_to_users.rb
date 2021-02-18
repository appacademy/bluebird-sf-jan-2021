class AddAgeAndPaToUsers < ActiveRecord::Migration[5.2]
  def change
    # add_column :table_name, :column_name, :data_type, options
    add_column :users, :age, :integer, null: false
    add_column :users, :political_affiliation, :string, null: false
  end
end
