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
class Memo < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
end
