# frozen_string_literal: true

RSpec.describe 'Memos' do
  describe 'MemoAPI' do
    context 'タイトルとコンテンツが有効な場合' do
      let(:valid_memo_params) { attributes_for(:memo) }

      it 'memoレコードが追加され、204になる' do
        aggregate_failures do
          expect { post '/memos', params: { memo: valid_memo_params } }.to change(Memo, :count).by(+1)
          expect(response).to have_http_status(:no_content)
        end
      end

      it 'リクエストボディが返される。' do
        post '/memos', params: { memo: valid_memo_params }
        expect(response.body).to be_empty
      end
    end

    context 'バリデーションエラーになる場合' do
      let(:empty_memo_params) { { title: '', content: '' } }

      it '422のステータスが返ってくる' do
        post '/memos', params: { memo: empty_memo_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'response.bodyに「タイトルを入力してください,コンテンツを入力してください」が返ってくる。' do
        post '/memos', params: { memo: empty_memo_params }
        expect(response.parsed_body['errors']).to eq(%w[タイトルを入力してください コンテンツを入力してください])
      end
    end
  end
end
