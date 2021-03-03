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
#  password_digest       :string           not null
#  session_token         :string           not null
#
class User < ApplicationRecord
  # validates :column_name1, :column_name2, validation: one, validation: two 
  validates :username, :email, :session_token, presence: true, uniqueness: true
  # validates :age, :political_affiliation, presence: true
  validates :age, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  # private
  attr_reader :password

  public

  after_initialize :ensure_session_token # method is run after initialization 

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

  # def password
  #   p "password getter"
  #   @password
  # end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username) # find user by unique username, returns user object
    if user && user.password?(password)
      user
    else
      nil
    end
  end

  def password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password) 
    # create BCrypt Object using digest
    # call is_password? (BCrypt method) on the object while passing in the password string
    # returns true if it matches and false if not
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password) # creates password_digest string
    # p "password setter"
    @password = password
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64 # creates random string
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64 # new string
    self.save! # save (with loud errors)
    self.session_token # return token
  end

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
