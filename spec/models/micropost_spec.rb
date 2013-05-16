# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#

#  content    :string          in translations table

require 'spec_helper'

describe Micropost do

  let(:user)      { create(:user) }
  let(:micropost) { build(:micropost, user: user) }

  specify "Globalize3 model attributes" do
    expect(micropost).to respond_to(:translations, :content)
  end

  specify "associations" do
    expect(micropost).to belong_to(:user)
    expect(micropost.user).to eql(user)
  end

  specify "class level methods" do
    expect(micropost.class).to \
      respond_to(:from_users_actively_followed_by).with(1).argument
    expect(micropost.class).to \
      respond_to(:eagerly_paginate).with(1).argument
  end

  specify "initial state" do
    expect(micropost).to be_valid
  end

  specify "validations" do
    expect(micropost).to validate_presence_of(:user)
    expect(micropost).to validate_presence_of(:content)
    expect(micropost).to_not allow_value(" ").for(:content)
    expect(micropost).to ensure_length_of(:content).is_at_most(140)
  end

  # self.from_users_actively_followed_by(user) tested in user_spec status
end
