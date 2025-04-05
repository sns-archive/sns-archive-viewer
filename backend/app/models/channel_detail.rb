# frozen_string_literal: true

# == Schema Information
#
# Table name: channel_details
#
#  id                          :bigint           not null, primary key
#  description(チャンネル説明) :string(100)      not null
#  channel_id(チャンネルID)    :bigint           not null
#
# Indexes
#
#  index_channel_details_on_channel_id  (channel_id)
#
# Foreign Keys
#
#  fk_chanel_id_on_channel_details  (channel_id => channels.id)
#

class ChannelDetail < ApplicationRecord
  belongs_to :channel

  validates :description, presence: true
  validates :description, length: { maximum: 100 }
end
