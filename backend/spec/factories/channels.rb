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

FactoryBot.define do
    factory :channel do
        name { Faker::Lorem.sentence(word_count: 3) }
        is_public { Faker::Boolean.boolean }
    end
end
