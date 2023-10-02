# frozen_string_literal: true

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
FactoryBot.define do
  factory :user do
    email { 'hogehoge@example.com' }
    password { 'sample_password' }
  end
end
