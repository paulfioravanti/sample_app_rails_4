# == Schema Information
#
# Table name: users
#
#  admin           :boolean          default(FALSE)
#  created_at      :datetime
#  email           :string(255)
#  id              :integer          not null, primary key
#  name            :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  updated_at      :datetime
#
# Indexes
#
#  index_users_on_email           (email) UNIQUE
#  index_users_on_remember_token  (remember_token)
#

require 'spec_helper'

describe User do

  let(:user) { create(:user) }

  specify "model attributes" do
    expect(user).to respond_to(:name, :email, :password_digest,
                               :remember_token, :admin)
  end

  specify "associations" do
    expect(user).to have_many(:microposts).dependent(:destroy)
    expect(user).to have_many(:active_relationships)
                    .class_name("Relationship")
                    .dependent(:destroy)
    expect(user).to have_many(:followed_users).through(:active_relationships)
    expect(user).to have_many(:passive_relationships)
                    .class_name("Relationship")
                    .dependent(:destroy)
    expect(user).to have_many(:followers).through(:passive_relationships)
  end

  specify "virtual attributes/methods from has_secure_password" do
    expect(user).to respond_to(:password, :password_confirmation, :authenticate)
  end

  specify "instance methods" do
    expect(user).to respond_to(:feed).with(0).arguments
    expect(user).to respond_to(:following?).with(1).argument
    expect(user).to respond_to(:follow!).with(1).argument
    expect(user).to respond_to(:unfollow!).with(1).argument
  end

  specify "class level methods" do
    expect(user.class).to respond_to(:authenticate).with(2).arguments
  end

  specify "initial state" do
    expect(user).to be_valid
    expect(user).to_not be_admin
    expect(user.remember_token).to_not be_blank
    expect(user.email).to_not match(%r(\p{Upper}))
  end

  describe "validations" do
    specify "for name" do
      expect(user).to validate_presence_of(:name)
      expect(user).to_not allow_value(" ").for(:name)
      expect(user).to ensure_length_of(:name).is_at_most(50)
    end

    specify "for email" do
      expect(user).to validate_presence_of(:email)
      expect(user).to_not allow_value(" ").for(:email)
      expect(user).to validate_uniqueness_of(:email).case_insensitive
      invalid_email_addresses.each do |invalid_address|
        expect(user).to_not allow_value(invalid_address).for(:email)
      end
      valid_email_addresses.each do |valid_address|
        expect(user).to allow_value(valid_address).for(:email)
      end
    end

    specify "for password" do
      # validation of presence and confirmation of password
      # done in has_secure_password
      expect(user).to ensure_length_of(:password).is_at_least(6)
      expect(user).to_not allow_value("mismatch").for(:password_confirmation)
    end
  end

  specify "when admin attribute set to 'true'" do
    user.toggle!(:admin)
    expect(user).to be_admin
  end

  describe "#authenticate from has_secure_password" do
    let(:found_user) { User.find_by_email(user.email) }
    let(:successfully_authenticated_user) do
      found_user.authenticate(user.password)
    end
    let(:unsuccessfully_authenticated_user) do
      found_user.authenticate("invalid")
    end

    specify "with valid password" do
      expect(user).to eq(successfully_authenticated_user)
    end

    specify "with invalid password" do
      expect(user).to_not eq(unsuccessfully_authenticated_user)
      expect(unsuccessfully_authenticated_user).to be_false
    end
  end

  describe "micropost associations" do
    let!(:older_micropost) do
      create(:micropost, user: user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      create(:micropost, user: user, created_at: 1.hour.ago)
    end
    let(:destroying_a_user) { -> { user.destroy } }

    specify "microposts scoped to be ordered by created_at DESC" do
      expect(user.microposts.by_descending_date).to \
        eq([newer_micropost, older_micropost])
    end

    specify "when user is destroyed" do
      expect(destroying_a_user).to change(Micropost, :count).by(-2)
    end

    describe "status" do
      let(:unfollowed_post) { create(:micropost, user: create(:user)) }
      let(:followed_user) { create(:user) }

      before do
        user.follow!(followed_user)
        3.times { followed_user.microposts.create!(content: "Lorem Ipsum") }
      end

      specify "feed contents" do
        expect(user.feed).to include(newer_micropost)
        expect(user.feed).to include(older_micropost)
        expect(user.feed).to_not include(unfollowed_post)
        followed_user.microposts.each do |micropost|
          expect(user.feed).to include(micropost)
        end
      end
    end
  end

  describe "#follow!" do
    let(:other_user) { create(:user) }

    before { user.follow!(other_user) }

    specify "when user follows another user" do
      expect(user).to be_following(other_user)
      expect(user.followed_users).to include(other_user)
      expect(other_user.followers).to include(user)
    end

    describe "#unfollow!" do
      before { user.unfollow!(other_user) }

      specify "when a user unfollows another user" do
        expect(user).to_not be_following(other_user)
        expect(user.followed_users).to_not include(other_user)
        expect(other_user.followers).to_not include(user)
      end
    end
  end

  describe "relationship associations" do
    let(:other_user) { create(:user) }
    let(:destroying_a_user) { -> { user.destroy } }
    let(:destroying_a_follower_or_followed_user) { -> { other_user.destroy } }

    before do
      user.follow!(other_user)
      other_user.follow!(user)
    end

    specify "when a user is destroyed" do
      expect(destroying_a_user).to change(Relationship, :count).by(-2)
      expect(user.active_relationships).to be_empty
      expect(user.passive_relationships).to be_empty
      expect(other_user.active_relationships).to_not include(user)
      expect(other_user.passive_relationships).to_not include(user)
    end

    specify "when a follower/followed user is destroyed" do
      expect(destroying_a_follower_or_followed_user).to \
        change(Relationship, :count).by(-2)
      expect(user.active_relationships).to_not include(user)
      expect(user.passive_relationships).to_not include(user)
    end
  end
end
