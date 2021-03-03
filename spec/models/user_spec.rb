require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    # it "validates the presence of a username" do 
      # incomplete_user = User.new(username: '', age: 99, email: "a@a.com", password: '123456') 
      # expect(incomplete_user).to_not be_valid
    # end
    subject(:toby) { User.create(username: 'toby', age: 2, email: 'toby@toby.com', password: "123456")}

    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:age)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_presence_of(:session_token)}
    it { should validate_length_of(:password).is_at_least(6)}

    it { should validate_uniqueness_of(:username)}
  end

  describe 'associations' do
    it { should have_many(:chirps)}
    it { should have_many(:likes)}
    it { should have_many(:liked_chirps)}
  end

  describe "#password?" do
    let(:user) { FactoryBot.build(:user) }

    context "with a valid password" do
      it "should return true" do 
        expect(user.password?("password")).to be true 
      end 
    end

    context "with an invalid password" do
      it "should return false" do 
        expect(user.password?("banana")).to be false 
      end 
    end 

  end

  describe "password encrytion" do
    it "does not save password to the database" do 
      FactoryBot.create(:harry_potter)

      user = User.find_by(username: 'Harry Potter')

      expect(user.password).not_to eq('starwars')
    end 

    it "encrypts password using BCrypt" do 
      expect(BCrypt::Password).to receive(:create).with('abcdef')

      FactoryBot.build(:user, password: 'abcdef')
    end 
  end

end
