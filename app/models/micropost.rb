# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#

#  content    :string          in translations table

class Micropost < ActiveRecord::Base
  translates :content
  belongs_to :user

  default_scope -> { order('created_at DESC') }

  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  def self.from_users_actively_followed_by(user)
    followed_users = Relationship.with_users_actively_followed_by(user).to_sql
    where("user_id IN (#{followed_users}) OR user_id = :user",
          user: user)
  end

  def self.eagerly_paginate(page)
    includes([:user, :translations]).paginate(page: page)
  end
end
