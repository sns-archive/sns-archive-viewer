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
RSpec.describe Memo do
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
        expect(memo).not_to be_valid
      end

      it 'errorsに「タイトルを入力してください」と格納されること' do
        memo.valid?
        expect(memo.errors.full_messages).to eq ['タイトルを入力してください']
      end
    end

    context 'titleがnilの場合' do
      before { memo.title = nil }

      it 'valid?メソッドがfalseを返すこと' do
        expect(memo).not_to be_valid
      end

      it 'errorsに「タイトルを入力してください」と格納されること' do
        memo.valid?
        expect(memo.errors.full_messages).to eq ['タイトルを入力してください']
      end
    end

    context 'contentが空文字の場合' do
      before { memo.content = '' }

      it 'valid?メソッドがfalseを返すこと' do
        expect(memo).not_to be_valid
      end

      it 'errorsに「コンテンツを入力してください」と格納されること' do
        memo.valid?
        expect(memo.errors.full_messages).to eq ['コンテンツを入力してください']
      end
    end

    context 'contentがnilの場合' do
      before { memo.content = nil }

      it 'valid?メソッドがfalseを返すこと' do
        expect(memo).not_to be_valid
      end

      it 'errorsに「コンテンツを入力してください」と格納されること' do
        memo.valid?
        expect(memo.errors.full_messages).to eq ['コンテンツを入力してください']
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        association = described_class.reflect_on_association(:comments)
        expect(association.macro).to eq(:has_many)
      end
    end
  end
end
