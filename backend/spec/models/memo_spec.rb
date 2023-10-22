# frozen_string_literal: true

# == Schema Information
#
# Table name: memos
#
#  id                    :bigint           not null, primary key
#  content(メモの本文)   :text(65535)      not null
#  title(メモのタイトル) :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
RSpec.describe Memo, type: :model do
  subject(:memo) { build(:memo) }

  describe 'バリデーションのテスト' do
    context 'title と content が有効な場合' do
      it 'valid?メソッドがtrueを返すこと' do
        expect(memo).to be_valid
      end
    end

    context 'titleが空文字の場合' do
      before { memo.title = '' }

      it 'valid?メソッドがfalseを返すこと' do
        expect(memo).to be_invalid
      end

      it 'errorsに「タイトルを入力してください」と格納されること' do
        memo.valid?
        expect(memo.errors.full_messages).to eq ['タイトルを入力してください']
      end
    end

    context 'titleがnilの場合' do
      before { memo.title = nil }

      it 'valid?メソッドがfalseを返すこと' do
        expect(memo).to be_invalid
      end

      it 'errorsに「タイトルを入力してください」と格納されること' do
        memo.valid?
        expect(memo.errors.full_messages).to eq ['タイトルを入力してください']
      end
    end

    context 'contentが空文字の場合' do
      before { memo.content = '' }

      it 'valid?メソッドがfalseを返すこと' do
        expect(memo).to be_invalid
      end

      it 'errorsに「コンテンツを入力してください」と格納されること' do
        memo.valid?
        expect(memo.errors.full_messages).to eq ['コンテンツを入力してください']
      end
    end

    context 'contentがnilの場合' do
      before { memo.content = nil }

      it 'valid?メソッドがfalseを返すこと' do
        expect(memo).to be_invalid
      end

      it 'errorsに「コンテンツを入力してください」と格納されること' do
        memo.valid?
        expect(memo.errors.full_messages).to eq ['コンテンツを入力してください']
      end
    end
  end
end
