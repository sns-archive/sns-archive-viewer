# frozen_string_literal: true

# == Schema Information
#
# Table name: channels
#
#  id                      :bigint           not null, primary key
#  is_public(公開・非公開) :boolean          not null
#  name(チャンネル名)      :string(50)       not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Channel < ApplicationRecord
    has_one :channel_detail, dependent: :destroy

    validates :name, presence: true
    validates :name, length: { maximum: 50 }
    validates :is_public, inclusion: [true, false]
end
