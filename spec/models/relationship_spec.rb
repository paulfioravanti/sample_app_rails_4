# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer          not null
#  followed_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#

require 'spec_helper'

describe Relationship do

  let(:follower) { create(:user) }
  let(:followed) { create(:user) }
  let(:active_relationship) do
    follower.active_relationships.build(followed_id: followed.id)
  end

  specify "associations" do
    expect(active_relationship).to belong_to(:follower).class_name("User")
    expect(active_relationship).to belong_to(:followed).class_name("User")
    expect(active_relationship.follower).to eq(follower)
    expect(active_relationship.followed).to eq(followed)
  end

  specify "class level methods" do
    expect(active_relationship.class).to \
      respond_to(:with_users_actively_followed_by).with(1).argument
  end

  specify "validations" do
    expect(active_relationship).to validate_presence_of(:follower)
    expect(active_relationship).to validate_presence_of(:followed)
  end

  specify "initial state" do
    expect(active_relationship).to be_valid
  end
end
