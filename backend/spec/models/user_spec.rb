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
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = build(:user)
    expect(user).to be_valid
  end
end
