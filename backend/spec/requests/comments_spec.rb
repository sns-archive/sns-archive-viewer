# frozen_string_literal: true

RSpec.describe 'CommentsController' do
  describe 'POST /memos/:memo_id/comments' do
    context 'コンテンツが有効な場合' do
      let(:memo) { create(:memo) }
      let(:valid_comment_params) { { content: Faker::Lorem.paragraph(sentence_count: 3) } }

      it 'コメントが追加され、204になる' do
        aggregate_failures do
          expect do
            post "/memos/#{memo.id}/comments", params: { comment: valid_comment_params }, as: :json
          end.to change(Comment, :count).by(1)

          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_empty
        end
      end
    end

    context 'バリデーションエラーになる場合' do
      let(:memo) { create(:memo) }
      let(:invalid_comment_params) { { content: '' } }

      it '422になり、エラーメッセージがレスポンスとして返る' do
        aggregate_failures do
          post "/memos/#{memo.id}/comments", params: { comment: invalid_comment_params }, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body['errors']).to eq(['内容を入力してください'])
        end
      end
    end
  end
end
