require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}
    it {should validate_length_of(:password).is_at_least(6)}
  end

  # describe 'associations' do
  #  it { should have_many(:goals)}
  #  it { should have_many(:comments)}
  # end

  it 'doesn\'t save password to database' do
  User.create(username: 'tony123', password: 'password')
    tony = User.find_by_credentials('tony123', 'password')
    expect(tony.password).not_to be('password')
  end

  it 'saving password with BCrypt' do
    expect(BCrypt::Password).to receive(:create).with('password')
    felix = User.create(username: 'felix123', password: 'password')
  end


end
