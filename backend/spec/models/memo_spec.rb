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

  describe 'Query::resolve(memos:, params:)' do
    let!(:memos) do
      {
        '1' => create(:memo, title: 'テスト タイトル１', content: 'テスト コンテンツ１'),
        '2' => create(:memo, title: 'テスト タイトル２', content: 'テスト コンテンツ２'),
        '3' => create(:memo, title: 'その他 タイトル', content: 'その他 コンテンツ')
      }
    end

    context 'タイトル検索のテスト' do
      context 'タイトルで検索した場合' do
        it 'タイトルフィルターが正しく機能し、期待されるメモが取得できることを確認する' do
          aggregate_failures do
            result = Memo::Query.resolve(memos: described_class.all, params: { title: 'テスト' })
            expect(result).to contain_exactly(memos['1'], memos['2'])
            expect(result).not_to include(memos['3'])
          end
        end
      end

      context 'タイトルなしで検索した場合' do
        it 'すべてのメモが取得できることを確認する' do
          aggregate_failures do
            result = Memo::Query.resolve(memos: described_class.all, params: {})
            expect(result).to contain_exactly(memos['1'], memos['2'], memos['3'])
          end
        end
      end
    end

    context 'コンテンツ検索のテスト' do
      context 'コンテンツで検索した場合' do
        it 'コンテンツフィルターが正しく機能し、期待されるメモが取得できることを確認する' do
          aggregate_failures do
            result = Memo::Query.resolve(memos: described_class.all, params: { content: 'コンテンツ' })
            expect(result).to contain_exactly(memos['1'], memos['2'], memos['3'])
          end
        end
      end

      context 'コンテンツなしで検索した場合' do
        it 'すべてのメモが取得できることを確認する' do
          aggregate_failures do
            result = Memo::Query.resolve(memos: described_class.all, params: {})
            expect(result).to contain_exactly(memos['1'], memos['2'], memos['3'])
          end
        end
      end
    end

    context 'タイトルとコンテンツ検索のテスト' do
      context 'タイトルとコンテンツで検索した場合' do
        it 'タイトルとコンテンツの両方でフィルターが正しく機能し、期待されるメモが取得できることを確認する' do
          aggregate_failures do
            result = Memo::Query.resolve(memos: described_class.all, params: { title: 'その他', content: 'コンテンツ' })
            expect(result).to contain_exactly(memos['3'])
            expect(result).not_to include(memos['1'], memos['2'])
          end
        end
      end
    end

    context '並び替え機能のテスト' do
      context '昇順で検索した場合' do
        it '昇順機能が正しく機能していること' do
          aggregate_failures do
            result = Memo::Query.resolve(memos: described_class.all, params: { order: 'asc' })
            expect(result).to eq([memos['1'], memos['2'], memos['3']])
          end
        end
      end

      context '並び順を指定しなかった場合' do
        it 'デフォルトで降順機能が正しく機能されていること' do
          aggregate_failures do
            result = Memo::Query.resolve(memos: described_class.all, params: {})
            expect(result).to eq([memos['3'], memos['2'], memos['1']])
          end
        end
      end
    end
  end
end
