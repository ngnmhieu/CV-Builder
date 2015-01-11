require 'rails_helper'

describe User, :type => :model do
  describe "Validation" do
    it "be a valid factory object" do
      expect(build(:user)).to be_valid
    end

    it "is not valid without email address" do
      user_without_email = build(:user, email: nil)
      expect(user_without_email).not_to be_valid
    end

    it "is not valid without password" do
      user_without_pass = build(:user, password: nil)
      expect(user_without_pass).not_to be_valid
    end

    it "should have email address with valid format" do
      bad_emails = Array.new
      good_emails = Array.new
      bad_emails << build(:user, email: 'illform_emailnowhere')
      bad_emails << build(:user, email: 'illform_email@nowhere')
      good_emails << build(:user, email: 'good@tdd.com')
      good_emails << build(:user, email: 'some.body_else@tdd.com.vn')

      bad_emails.each { |user| expect(user).not_to be_valid }
      good_emails.each { |user| expect(user).to be_valid }

    end

    it "should have an unique email address" do
      create(:user)
      existing_user = build(:user)

      expect(existing_user).not_to be_valid
    end

    it "should have a default name if attribute name is not provided" do
      user = create(:user, email: 'my_buddy@gmail.com')
      expect(user.name).to eq 'My_buddy'
    end

    it "should not set default name if it's provided" do
      user = create(:user, name: "Hieu", email: 'my_buddy@gmail.com')
      expect(user.name).to eq 'Hieu'
    end

    it "authenticate user correctly" do
      user = create(:user)
      expect(User.authenticate(user.email, user.password)).not_to be false
      expect(User.authenticate(user.email, "wrong passord")).to be false
    end

  end
end
