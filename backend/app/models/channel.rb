# frozen_string_literal: true

# == Schema Information
#
# Table name: channels
#
#  id                                           :bigint           not null, primary key
#  name(チャンネル名)                           :string(50)       not null
#  public_mark(公開(true)・非公開(false)の設定) :boolean          not null
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#

class Channel < ApplicationRecord
  has_one :channel_detail, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 50 }
  validates :public_mark, inclusion: [true, false]
end
