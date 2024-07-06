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
class User < ApplicationRecord
end
