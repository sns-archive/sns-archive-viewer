# frozen_string_literal: true

RSpec.describe 'MemosController' do
  describe 'POST /memos' do
    context 'タイトルとコンテンツが有効な場合' do
      let(:valid_memo_params) do
        { title: Faker::Lorem.sentence(word_count: 3), content: Faker::Lorem.paragraph(sentence_count: 5) }
      end

      it 'memoレコードが追加され、204になる' do
        aggregate_failures do
          expect { post '/memos', params: { memo: valid_memo_params } }.to change(Memo, :count).by(+1)
          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_empty
        end
      end
    end

    context 'バリデーションエラーになる場合' do
      let(:empty_memo_params) { { title: '', content: '' } }

      it '422になり、エラーメッセージがレスポンスとして返る' do
        aggregate_failures do
          post '/memos', params: { memo: empty_memo_params }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body['errors']).to eq(%w[タイトルを入力してください コンテンツを入力してください])
        end
      end
    end
  end

  describe 'PUT /memos/:id' do
    context 'コンテンツが有効な場合' do
      let(:existing_memo) { create(:memo) }
      let(:params) { { content: '新しいコンテンツ' } }

      it 'memoが更新され、204になる' do
        aggregate_failures do
          put "/memos/#{existing_memo.id}", params: { memo: params }
          expect(response).to have_http_status(:no_content)
          existing_memo.reload
          expect(existing_memo.content).to eq('新しいコンテンツ')
        end
      end
    end

    context 'バリデーションエラーになる場合' do
      let(:existing_memo) { create(:memo) }
      let(:params) { { content: '' } }

      it '422になり、エラーメッセージがレスポンスとして返る' do
        aggregate_failures do
          put "/memos/#{existing_memo.id}", params: { memo: params }
          existing_memo.reload
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body['errors']).to eq(['コンテンツを入力してください'])
        end
      end
    end
  end

  context 'タイトルを更新しようとした場合' do
    let(:existing_memo) { create(:memo) }
    let(:params) { { title: '新しいタイトル' } }

    it 'タイトルが変更されていないことを確認する' do
      aggregate_failures do
        put "/memos/#{existing_memo.id}", params: { memo: params }
        expect(response).to have_http_status(:no_content)
        existing_memo.reload
        expect(existing_memo.title).not_to eq('新しいタイトル')
      end
    end
  end

  describe 'DELETE /memos/:id' do
    context 'メモを削除しようとした場合' do
      let!(:existing_memo) { create(:memo) }

      it 'メモを削除されたことを確認する' do
        aggregate_failures do
          expect { delete "/memos/#{existing_memo.id}" }.to change(Memo, :count).by(-1)
          expect(response).to have_http_status(:no_content)
        end
      end
    end

    context '存在しないメモを削除しようとした場合' do
      it '404が返ることを確認する' do
        aggregate_failures do
          expect { delete '/memos/0' }.not_to change(Memo, :count)
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
