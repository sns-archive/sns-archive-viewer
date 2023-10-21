# frozen_string_literal: true

# == Schema Information
#
# Table name: memos
#
#  id                    :bigint           not null, primary key
#  content(メモの本文)   :string(255)      not null
#  title(メモのタイトル) :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
RSpec.describe Memo, type: :model do
  describe 'バリデーションのテスト' do
    context 'title と content が有効な場合' do
      let(:memo) { build(:memo) }

      it 'valid?メソッドがtrueを返す' do
        expect(memo.valid?).to eq true
      end
    end

    context 'titleが空文字の場合' do
      let(:memo) { build(:memo, title: '') }

      it 'valid?メソッドがfalseを返し、errorsに「タイトルを入力してください」と格納される' do
        aggregate_failures do
          result = memo.valid?
          expect(result).to eq false
          expect(memo.errors.full_messages).to eq ['タイトルを入力してください']
        end
      end
    end

    context 'titleがnilの場合' do
      let(:memo) { build(:memo, title: nil) }

      it 'valid?メソッドがfalseを返し、errorsに「タイトルを入力してください」と格納される' do
        aggregate_failures do
          result = memo.valid?
          expect(result).to eq false
          expect(memo.errors.full_messages).to eq ['タイトルを入力してください']
        end
      end
    end

    context 'contentが空文字の場合' do
      let(:memo) { build(:memo, content: '') }

      it 'valid?メソッドがfalseを返し、errorsに「コンテンツを入力してください」と格納される' do
        aggregate_failures do
          result = memo.valid?
          expect(result).to eq false
          expect(memo.errors.full_messages).to eq ['コンテンツを入力してください']
        end
      end
    end

    context 'contentがnilの場合' do
      let(:memo) { build(:memo, content: nil) }

      it 'valid?メソッドがfalseを返し、errorsに「コンテンツを入力してください」と格納される' do
        aggregate_failures do
          result = memo.valid?
          expect(result).to eq false
          expect(memo.errors.full_messages).to eq ['コンテンツを入力してください']
        end
      end
    end
  end
end
