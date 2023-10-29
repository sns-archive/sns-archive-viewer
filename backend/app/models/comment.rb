# == Schema Information
#
# Table name: comments
#
#  id                                  :bigint           not null, primary key
#  content(コメントの内容)             :text(65535)      not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  memo_id(コメントが参照するメモのID) :integer          not null
#
# Indexes
#
#  index_comments_on_memo_id  (memo_id)
#
class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :memo
end
