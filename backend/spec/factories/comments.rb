# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id              :bigint           not null, primary key
#  content(内容)   :text(65535)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  memo_id(メモID) :bigint           not null
#
# Indexes
#
#  index_comments_on_memo_id  (memo_id)
#
# Foreign Keys
#
#  fk_rails_...  (memo_id => memos.id)
#

FactoryBot.define do
  factory :comment do
    content { 'sample_comment' }
    memo
  end
end
