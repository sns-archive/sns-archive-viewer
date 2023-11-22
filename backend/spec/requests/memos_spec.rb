# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Memos' do
  describe 'MemoAPI' do
    let(:valid_memo_params) { attributes_for(:memo) }
    let(:empty_memo_params) { { title: '', content: '' } }
    let(:empty_title_memo_params) { { title: '', content: 'test_content' } }
    let(:empty_content_memo_params) { { title: 'test_title', content: '' } }

    context 'タイトルとコンテンツが有効な場合' do
      before do
        post '/memos', params: { memo: valid_memo_params }
      end

      it 'レコードが追加される' do
        expect { post '/memos', params: { memo: valid_memo_params } }.to change(Memo, :count).by(+1)
      end

      it '204のステータスが返ってくる。' do
        expect(response).to have_http_status(:no_content)
      end

      it 'リクエストボディが返される。' do
        expect(response.body).to be_empty
      end
    end

    context 'タイトルとコンテンツが空の場合' do
      before do
        post '/memos', params: { memo: empty_memo_params }
      end

      it '422のステータスが返ってくる' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'response.bodyに「タイトルを入力してください,コンテンツを入力してください」が返ってくる。' do
        expect(response.body).to eq('{"errors":["タイトルを入力してください","コンテンツを入力してください"]}')
      end
    end

    context 'タイトルが空の場合' do
      before do
        post '/memos', params: { memo: empty_title_memo_params }
      end

      it '422のステータスが返ってくる' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'response.bodyに「タイトルを入力してください」が返ってくる。' do
        expect(response.body).to eq('{"errors":["タイトルを入力してください"]}')
      end
    end

    context 'コンテンツが空の場合' do
      before do
        post '/memos', params: { memo: empty_content_memo_params }
      end

      it '422のステータスが返ってくる' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'response.bodyに「コンテンツを入力してください」が返ってくる。' do
        expect(response.body).to eq('{"errors":["コンテンツを入力してください"]}')
      end
    end
  end
end
