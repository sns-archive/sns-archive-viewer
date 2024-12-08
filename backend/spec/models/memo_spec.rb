# frozen_string_literal: true

# == Schema Information
#
# Table name: memos
#
#  id                    :bigint           not null, primary key
#  content(メモの本文)   :text(65535)      not null
#  discarded_at          :datetime
#  title(メモのタイトル) :string(30)       not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_memos_on_discarded_at  (discarded_at)
#
RSpec.describe Memo do
  describe 'バリデーションのテスト' do
    let!(:memo) { build(:memo) }

    context '属性が正常な場合' do
      it 'trueを返す' do
        expect(memo).to be_valid
      end
    end

    context 'titleが空文字の場合' do
      before do
        memo.title = ''
      end

      it 'falseを返し、errorが格納される' do
        aggregate_failures do
          expect(memo).not_to be_valid
          expect(memo.errors.full_messages).to eq ['タイトルを入力してください']
        end
      end
    end

    context 'titleがnilの場合' do
      before { memo.title = nil }

      it 'falseになり、errorが格納される' do
        aggregate_failures do
          expect(memo).not_to be_valid
          expect(memo.errors.full_messages).to eq ['タイトルを入力してください']
        end
      end
    end

    context 'contentが空文字の場合' do
      before { memo.content = '' }

      it 'falseが返り、errorsに「コンテンツを入力してください」と格納されること' do
        aggregate_failures do
          expect(memo).not_to be_valid
          expect(memo.errors.full_messages).to eq ['コンテンツを入力してください']
        end
      end
    end

    context 'contentがnilの場合' do
      before { memo.content = nil }

      it 'falseになり、errorsが格納されること' do
        aggregate_failures do
          expect(memo).not_to be_valid
          expect(memo.errors.full_messages).to eq ['コンテンツを入力してください']
        end
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
