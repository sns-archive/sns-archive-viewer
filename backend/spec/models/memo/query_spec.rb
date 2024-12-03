# frozen_string_literal: true

RSpec.describe Memo::Query do
  describe 'Query::resolve(memos:, params:)' do
    let!(:memos) do
      {
        '1' => create(:memo, title: 'テスト タイトル１', content: 'テスト コンテンツ１'),
        '2' => create(:memo, title: 'テスト タイトル２', content: 'テスト コンテンツ２'),
        '3' => create(:memo, title: 'その他 タイトル', content: 'その他 コンテンツ')
      }
    end

    context 'タイトルで検索した場合' do
      it 'タイトルフィルターが正しく機能し、期待されるメモが取得できることを確認する' do
        aggregate_failures do
          result = described_class.resolve(memos: Memo.all, params: { title: 'テスト' })
          expect(result).to contain_exactly(memos['1'], memos['2'])
          expect(result).not_to include(memos['3'])
        end
      end
    end

    context 'コンテンツで検索した場合' do
      it 'コンテンツフィルターが正しく機能し、期待されるメモが取得できることを確認する' do
        aggregate_failures do
          result = described_class.resolve(memos: Memo.all, params: { content: 'コンテンツ' })
          expect(result).to contain_exactly(memos['1'], memos['2'], memos['3'])
        end
      end
    end

    context 'タイトルとコンテンツで検索した場合' do
      it 'タイトルとコンテンツの両方でフィルターが正しく機能し、期待されるメモが取得できることを確認する' do
        aggregate_failures do
          result = described_class.resolve(memos: Memo.all, params: { title: 'その他', content: 'コンテンツ' })
          expect(result).to contain_exactly(memos['3'])
          expect(result).not_to include(memos['1'], memos['2'])
        end
      end
    end

    context 'タイトルとコンテンツなしで検索した場合' do
      it 'すべてのメモが取得できることを確認する' do
        aggregate_failures do
          result = described_class.resolve(memos: Memo.all, params: {})
          expect(result).to contain_exactly(memos['1'], memos['2'], memos['3'])
        end
      end
    end

    context '昇順で検索した場合' do
      it '昇順機能が正しく機能していること' do
        aggregate_failures do
          result = described_class.resolve(memos: Memo.all, params: { order: 'asc' })
          expect(result).to eq([memos['1'], memos['2'], memos['3']])
        end
      end
    end

    context '並び順を指定しなかった場合' do
      it 'デフォルトで降順機能が正しく機能されていること' do
        aggregate_failures do
          result = described_class.resolve(memos: Memo.all, params: {})
          expect(result).to eq([memos['3'], memos['2'], memos['1']])
        end
      end
    end
  end
end
