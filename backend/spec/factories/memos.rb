# frozen_string_literal: true

# == Schema Information
#
# Table name: memos
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :memo do
    title { 'sample_title' }
    content { 'sample_content' }
  end
end
