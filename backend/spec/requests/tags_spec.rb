# frozen_string_literal: true

RSpec.describe 'TagsController' do
  describe 'POST /tags' do
    context 'パラメーターが有効な場合' do
      let(:params) { { label: Faker::Lorem.sentence(word_count: 5), color: :white, priority: 0 } }

      it 'タグが追加され、204が返る' do
        aggregate_failures do
          expect do
            post '/tags', params: params, as: :json
          end.to change(Tag, :count).by(1)

          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_empty
        end
      end
    end

    context 'パラメーターが無効な場合' do
      let(:params) { { label: '', color: :white, priority: 0 } }

      it 'タグが追加されていないこと、422が返ることを確認する' do
        aggregate_failures do
          expect do
            post '/tags', params: params, as: :json
          end.not_to change(Tag, :count)
          expect(response).to have_http_status(:unprocessable_content)
          expect(response.parsed_body['message']).to eq(['ラベルを入力してください'])
        end
      end
    end
  end

  describe 'PATCH /tags/:tag_id' do
    context 'パラメーターが有効な場合' do
      let!(:tag) { create(:tag) }
      let(:params) { { label: Faker::Lorem.sentence(word_count: 5) } }

      it 'タグが更新され、204が返る' do
        aggregate_failures do
          expect do
            patch "/tags/#{tag.id}", params: params, as: :json
          end.not_to change(Tag, :count)
          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_empty
          expect(Tag.find(tag.id)).to have_attributes(label: params[:label])
        end
      end
    end

    context 'パラメーターが無効な場合' do
      let!(:tag) { create(:tag) }
      let(:params) { { label: Faker::Lorem.sentence(word_count: 31) } }

      it 'タグが更新されていないこと、422が返ることを確認する' do
        aggregate_failures do
          expect do
            patch "/tags/#{tag.id}", params: params, as: :json
          end.not_to change(Tag, :count)
          expect(response).to have_http_status(:unprocessable_content)
          expect(response.parsed_body['message']).to eq(['ラベルは30文字以内で入力してください'])
        end
      end
    end
  end
end
