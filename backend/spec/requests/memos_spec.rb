require 'rails_helper'

RSpec.describe "Memos", type: :request do
  subject(:memo) { build(:memo) }

  describe 'MemoAPI' do
    context "タイトルとコンテンツが有効な場合" do
      it '204のステータスが返ってくる。' do
        memo_params = attributes_for(:memo)
        expect { post '/memos', params: { memo: memo_params } }.to change(Memo, :count).by(+1)
        expect(response.status).to eq(204)
        expect(response.body).to be_empty
      end
    end
  end
end
