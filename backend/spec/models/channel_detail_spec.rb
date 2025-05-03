# frozen_string_literal: true

# == Schema Information
#
# Table name: channel_details
#
#  id                          :bigint           not null, primary key
#  description(チャンネル説明) :string(100)      not null
#  channel_id(チャンネルID)    :bigint           not null
#
# Indexes
#
#  index_channel_details_on_channel_id         (channel_id)
#  unique_index_channel_details_on_channel_id  (channel_id) UNIQUE
#
# Foreign Keys
#
#  fk_chanel_id_on_channel_details  (channel_id => channels.id)
#
RSpec.describe ChannelDetail do
  describe 'バリデーションのテスト' do
    let!(:channel_detail) { build(:channel_detail) }

    context '属性が正常な場合' do
      it 'trueを返す' do
        expect(channel_detail).to be_valid
      end
    end

    context 'descriptionが空文字の場合' do
      before do
        channel_detail.description = ''
      end

      it 'falseを返し、errorが格納される' do
        aggregate_failures do
          expect(channel_detail).not_to be_valid
          expect(channel_detail.errors.full_messages).to eq ['チャンネル説明を入力してください']
        end
      end
    end

    context 'descriptionがnilの場合' do
      before do
        channel_detail.description = nil
      end

      it 'falseを返し、errorが格納される' do
        aggregate_failures do
          expect(channel_detail).not_to be_valid
          expect(channel_detail.errors.full_messages).to eq ['チャンネル説明を入力してください']
        end
      end
    end

    context 'descriptionが101文字の場合' do
      before do
        channel_detail.description = 'a' * 101
      end

      it 'falseを返し、errorが格納される' do
        aggregate_failures do
          expect(channel_detail).not_to be_valid
          expect(channel_detail.errors.full_messages).to eq ['チャンネル説明は100文字以内で入力してください']
        end
      end
    end
  end
end
