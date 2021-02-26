# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string           not null
#  email                 :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  age                   :integer          not null
#  political_affiliation :string
#
class User < ApplicationRecord
  # validates :column_name1, :column_name2, validation: one, validation: two 
  validates :username, :email, presence: true, uniqueness: true
  # validates :age, :political_affiliation, presence: true
  validates :age, presence: true

  has_many :chirps,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Chirp

  has_many :likes,
    foreign_key: :liker_id,
    class_name: :Like

  has_many :liked_chirps,
    through: :likes,
    source: :chirp

  #Get first user record, use first
  # User.first

  #Get last user record, use last
  # User.last

  #Find a user that exists by id, use find
  # User.find(13)

  #Find a user that doesn't exist by id, use find
  # User.find(200)
  # User.find_by(id: 200)

  #Find a user by username, use find_by
  # User.find_by(username: 'wakka_wakka')
  
  #Find a user by username that does not exist, use find_by
  # User.find_by(username: 'banana')

  #Find all users between the ages of 10 and 20 inclusive. Show their username, and political affiliation.
  # User.select(:username, :political_affiliation).where('age >= 10 AND age <= 20')
  # User.select(:username, :political_affiliation).where(age: 10..20)
  # User.select(:username, :p_a).where(age: 10..20) doesnt work

  #Find all users not younger than the age of 11. Use `where.not`
  # User.where.not('age < 11')
  # User.where.not('age < ?', 11)
  # User.where.not(age: 0...11) # includes users who are age 11
  # User.where.not(age: 0..11) # will not include any users of age 11

  #Find all political_affiliations of our users
  # User.select(:political_affiliation).distinct

  #Find all users who has a political affiliation in this list and order by ascending
  # political_affiliations = ["Ruby", "C"]
  # subquery = queryhere
  # User.where(political_affiliation: political_affiliations).order(username: :desc)

end
