# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id              :bigint           not null, primary key
#  content(内容)   :text(65535)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  memo_id(メモID) :integer          not null
#
# Indexes
#
#  index_comments_on_memo_id  (memo_id)
#
RSpec.describe Comment do
  subject(:comment) { build(:comment) }

  describe 'バリデーションのテスト' do
    context 'memo_idとcontentが有効な場合' do
      let(:memo) { create(:memo) }
      let(:comment) { build(:comment, memo: memo) }

      it 'valid?メソッドがtrueを返すこと' do
        expect(comment).to be_valid
      end
    end

    context 'contentが空文字の場合' do
      before { comment.content = ' ' }

      it 'valid?メソッドがfalseを返すこと' do
        expect(comment).not_to be_valid
      end

      it 'errorsに「内容を入力してください」と格納されること' do
        comment.valid?
        expect(comment.errors.full_messages).to eq ['内容を入力してください']
      end
    end

    context 'contentがnilの場合' do
      before { comment.content = nil }

      it 'valid?メソッドがfalseを返すこと' do
        expect(comment).not_to be_valid
      end

      it 'errorsに「内容を入力してください」と格納されること' do
        comment.valid?
        expect(comment.errors.full_messages).to eq ['内容を入力してください']
      end
    end

    context 'contentが1025文字以上の場合' do
      before { comment.content = 'a' * 1025 }

      it 'valid?メソッドがfalseを返すこと' do
        expect(comment).not_to be_valid
      end

      it 'errorsに「内容は1024文字以内で入力してください」と格納されること' do
        comment.valid?
        expect(comment.errors.full_messages).to eq ['内容は1024文字以内で入力してください']
      end
    end

    context 'contentが1024文字の場合' do
      before { comment.content = 'a' * 1024 }

      it 'valid?メソッドがtrueを返すこと' do
        expect(comment).to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Memoモデルとの関係' do
      it '1:Nの関係になっている' do
        association = described_class.reflect_on_association(:memo)
        expect(association.macro).to eq(:belongs_to)
      end
    end
  end
end
