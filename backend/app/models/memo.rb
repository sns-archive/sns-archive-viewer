# frozen_string_literal: true

# == Schema Information
#
# Table name: memos
#
#  id                    :bigint           not null, primary key
#  content(メモの本文)   :text(65535)      not null
#  title(メモのタイトル) :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Memo < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :memo_tags, dependent: :destroy
  has_many :tags, through: :memo_tags

  validates :title, presence: true
  validates :title, length: { maximum: 30 }
  validates :content, presence: true
end
