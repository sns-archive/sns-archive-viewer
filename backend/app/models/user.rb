# == Schema Information
#
# Table name: users
#
#  id                             :bigint           not null, primary key
#  email(ユーザーのEmailアドレス) :string(255)      not null
#  password(ユーザーのpassword)   :string(255)      not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# NOTE: ログイン機能は当分は実装しないため、このモデルは当分は使用しない。
class User < ApplicationRecord
  validates :email, presence: true, length: { maximum: 30 }
  validates :password, presence: true, length: { maximum: 30 }
end
