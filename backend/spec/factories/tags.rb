# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id               :bigint           not null, primary key
#  color(色)        :integer          not null
#  label(ラベル)    :string(30)       not null
#  priority(優先度) :float(24)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  unique_index_label_on_tags  (label) UNIQUE
#
FactoryBot.define do
  factory :tag do
    label { Faker::Lorem.sentence(word_count: 5) }
    color { Tag.colors.values.sample }
    priority { 0 }
  end
end
