# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id               :bigint           not null, primary key
#  color(色)        :integer          not null
#  label(ラベル)    :string(30)       not null
#  priority(優先度) :float(24)        not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  unique_index_label_on_tags  (label) UNIQUE
#
RSpec.describe Tag do
  describe 'バリデーションのテスト' do
    let!(:tag) { build(:tag) }

    context '属性が正常な場合' do
      it 'trueを返す' do
        expect(tag).to be_valid
      end
    end

    context 'labelがnilの場合' do
      before { tag.label = nil }

      it 'falseになり、errorsが格納される' do
        aggregate_failures do
          expect(tag).not_to be_valid
          expect(tag.errors.full_messages).to eq ['ラベルを入力してください']
        end
      end
    end

    context 'labelが31文字の場合' do
      before { tag.label = Faker::Lorem.characters(number: 31) }

      it 'falseになり、errorsが格納される' do
        aggregate_failures do
          expect(tag).not_to be_valid
          expect(tag.errors.full_messages).to eq ['ラベルは30文字以内で入力してください']
        end
      end
    end

    context 'colorがnilの場合' do
      before { tag.color = nil }

      it 'falseになり、errorsが格納される' do
        aggregate_failures do
          expect(tag).not_to be_valid
          expect(tag.errors.full_messages).to eq ['色を入力してください']
        end
      end
    end

    context 'priorityがnilの場合' do
      before { tag.priority = nil }

      it 'falseになり、errorsが格納される' do
        aggregate_failures do
          expect(tag).not_to be_valid
          expect(tag.errors.full_messages).to eq ['優先度を入力してください']
        end
      end
    end
  end
end
