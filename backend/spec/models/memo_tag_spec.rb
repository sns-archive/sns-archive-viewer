# frozen_string_literal: true

# == Schema Information
#
# Table name: memo_tags
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  memo_id(メモID) :bigint           not null
#  tag_id(タグID)  :bigint           not null
#
# Indexes
#
#  index_memo_tags_on_memo_id                    (memo_id)
#  index_memo_tags_on_tag_id                     (tag_id)
#  unique_index_memo_id_and_tag_id_on_memo_tags  (memo_id,tag_id) UNIQUE
#
# Foreign Keys
#
#  fk_memo_id_on_memo_tags  (memo_id => memos.id)
#  fk_tag_id_on_memo_tags   (tag_id => tags.id)
#
RSpec.describe MemoTag do
  describe 'バリデーションのテスト' do
    let!(:memo_tag) { build(:memo_tag) }

    context '属性が正常な場合' do
      it 'trueを返す' do
        expect(memo_tag).to be_valid
      end
    end

    context 'memo_idとtag_idが重複している場合' do
      let(:already_exist_model) { create(:memo_tag) }
      let(:model) do
        build(
          :memo_tag,
          memo: already_exist_model.memo,
          tag: already_exist_model.tag
        )
      end

      it 'falseになり、errorsが格納される' do
        aggregate_failures do
          expect(model).not_to be_valid
          expect(model.errors.full_messages).to eq ['メモはすでに存在します']
        end
      end
    end
  end
end
