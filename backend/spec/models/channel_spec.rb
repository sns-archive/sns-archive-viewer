# frozen_string_literal: true

# == Schema Information
#
# Table name: channels
#
#  id                      :bigint           not null, primary key
#  is_public(公開・非公開) :boolean          not null
#  name(チャンネル名)      :string(50)       not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

RSpec.describe Channel do
  describe 'バリデーションのテスト' do
    let!(:channel) { build(:channel) }

    context '属性が正常な場合' do
      it 'trueを返す' do
        expect(channel).to be_valid
      end
    end

    context 'nameが空文字の場合' do
      before do
        channel.name = ''
      end

      it 'falseを返し、errorが格納される' do
        aggregate_failures do
          expect(channel).not_to be_valid
          expect(channel.errors.full_messages).to eq ['チャンネル名を入力してください']
        end
      end
    end

    context 'nameがnilの場合' do
      before do
        channel.name = nil
      end

      it 'falseを返し、errorが格納される' do
        aggregate_failures do
          expect(channel).not_to be_valid
          expect(channel.errors.full_messages).to eq ['チャンネル名を入力してください']
        end
      end
    end

    context 'nameが51文字の場合' do
      before do
          channel.name = 'a' * 51
      end

      it 'falseを返し、errorが格納される' do
        aggregate_failures do
          expect(channel).not_to be_valid
          expect(channel.errors.full_messages).to eq ['チャンネル名は50文字以内で入力してください']
        end
      end
    end

    context 'is_publicがnilの場合' do
      before do
        channel.is_public = nil
      end

      it 'falseを返し、errorが格納される' do
        aggregate_failures do
          expect(channel).not_to be_valid
          expect(channel.errors.full_messages).to eq ['公開ステータスは一覧にありません']
        end
      end
    end

    context 'is_publicがtureの場合' do
      before do
        channel.is_public = true
      end

      it 'trueを返す' do
        expect(channel).to be_valid
      end
    end

    context 'is_publicがfalseの場合' do
      before do
        channel.is_public = false
      end

      it 'trueを返す' do
        expect(channel).to be_valid
      end
    end
  end
end
