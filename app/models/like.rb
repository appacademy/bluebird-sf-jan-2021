# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  chirp_id   :integer          not null
#  liker_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
