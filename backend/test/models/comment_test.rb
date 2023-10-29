# frozen_string_literal: true

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
require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
