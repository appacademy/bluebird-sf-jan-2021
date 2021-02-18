class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :chirp_id, null: false
      t.integer :liker_id, null: false

      t.timestamps
    end

    add_index :likes, [:chirp_id, :liker_id], unique: true
  end
end

# row 1
# chirp_id == 1
# liker_id == 2

# cant have this row
# chirp_id == 1
# liker_id == 2