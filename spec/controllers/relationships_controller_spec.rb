require 'spec_helper'

describe RelationshipsController do

  let(:user)       { create(:user) }
  let(:other_user) { create(:user) }
  let(:creating_a_relationship) do
    -> { xhr :post, :create, relationship: { followed_id: other_user.id } }
  end
  let(:relationship) do
    user.active_relationships.find_by_followed_id(other_user)
  end
  let(:destroying_a_relationship) do
    -> { xhr :delete, :destroy, id: relationship.id }
  end

  before do
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  end

  specify "a relationship gets created with Ajax" do
    expect(creating_a_relationship).to change(Relationship, :count).by(1)
    expect(response).to be_success
  end

  specify "a relationship gets destroyed with Ajax" do
    user.follow!(other_user)
    expect(destroying_a_relationship).to change(Relationship, :count).by(-1)
    expect(response).to be_success
  end
end