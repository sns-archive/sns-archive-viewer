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
RSpec.describe Memo, type: :model do
  describe 'バリデーションのテスト' do
    context 'titleとcontentが有効な場合' do
      let(:memo) { build(:memo) }

      it 'valid?メソッドがtrueを返す' do
        expect(memo.valid?).to eq true
      end
    end

    context 'titleが空文字の場合' do
      let(:memo) { build(:memo, title: '') }

      it 'valid?メソッドがfalseを返す' do
        expect(memo.valid?).to eq false
      end
    end

    context 'titleがnilの場合' do
      let(:memo) { build(:memo, title: nil) }

      it 'valid?メソッドがfalseを返す' do
        expect(memo.valid?).to eq false
      end
    end

    context 'contentが空文字の場合' do
      let(:memo) { build(:memo, content: '') }

      it 'valid?メソッドがfalseを返す' do
        expect(memo.valid?).to eq false
      end
    end

    context 'contentがnilの場合' do
      let(:memo) { build(:memo, content: nil) }

      it 'valid?メソッドがfalseを返す' do
        expect(memo.valid?).to eq false
      end
    end
  end
end
