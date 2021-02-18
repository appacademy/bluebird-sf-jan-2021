# == Schema Information
#
# Table name: chirps
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chirp < ApplicationRecord
  # built in validations
  validates :body, presence: true

  # custom validations
  validate :body_too_long

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User
    # optional: true # make an association optional (no validation on the foreign key)

  has_many :likes,
    foreign_key: :chirp_id,
    class_name: :Like

  has_many :likers,
    through: :likes,
    source: :liker

  def body_too_long
    # check to see if body exists before calling .length on it
    if body && body.length > 140
      errors[:body] << 'is too long.'
    end
  end
end
