require 'rails_helper'

describe DefaultIdentity, type: :model do
  it "be a valid factory object" do
    expect(build(:default_identity)).to be_valid
  end

  describe "Validation" do
    it "is not valid without email address" do
      identity_wo_email = build(:default_identity, email: nil)
      expect(identity_wo_email).not_to be_valid
    end

    it "is not valid without password" do
      identity_without_pass = build(:default_identity, password: nil)
      expect(identity_without_pass).not_to be_valid
    end

    it "should have email address with valid format" do
      bad_emails = Array.new
      good_emails = Array.new
      bad_emails << build(:default_identity, email: 'illform_emailnowhere')
      bad_emails << build(:default_identity, email: 'illform_email@nowhere')
      good_emails << build(:default_identity, email: 'good@tdd.com')
      good_emails << build(:default_identity, email: 'some.body_else@tdd.com.vn')

      bad_emails.each { |identity| expect(identity).not_to be_valid }
      good_emails.each { |identity| expect(identity).to be_valid }
    end

    it "should have an unique email address" do
      create(:default_identity)
      new_user = build(:default_identity)

      expect(new_user).not_to be_valid
    end
  end

  describe "Authentication" do
    let(:identity) { create(:default_identity) }

    it "allow authenticated user in" do
      expect(DefaultIdentity.authenticate(identity.email, identity.password)).to eq identity
    end

    it "don't allow not authentiated user in " do
      expect(DefaultIdentity.authenticate(identity.email, "wrong_password")).to be false
    end
  end
end
