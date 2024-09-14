# frozen_string_literal: true

# == Schema Information
#
# Table name: memo_tags
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  memo_id(メモID) :bigint           not null
#  tag_id(タグID)  :bigint           not null
#
# Indexes
#
#  index_memo_tags_on_memo_id                    (memo_id)
#  index_memo_tags_on_tag_id                     (tag_id)
#  unique_index_memo_id_and_tag_id_on_memo_tags  (memo_id,tag_id) UNIQUE
#
# Foreign Keys
#
#  fk_memo_id_on_memo_tags  (memo_id => memos.id)
#  fk_tag_id_on_memo_tags   (tag_id => tags.id)
#
FactoryBot.define do
  factory :memo_tag do
    memo
    tag
  end
end
