class Like < ApplicationRecord
  # Sets up validation for the combination of these two columns
  validates :chirp_id, uniqueness: { scope: :liker_id }

  belongs_to :chirp,
    foreign_key: :chirp_id,
    class_name: :Chirp

  belongs_to :liker,
    foreign_key: :liker_id,
    class_name: :User
end