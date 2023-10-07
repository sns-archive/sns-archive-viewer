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
RSpec.describe User, type: :model do
  it "有効な属性を持つ場合" do
    user = build(:user)
    expect(user).to be_valid
  end
end
