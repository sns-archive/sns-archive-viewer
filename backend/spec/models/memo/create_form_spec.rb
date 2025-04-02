# frozen_string_literal: true

RSpec.describe Memo::CreateForm do
  describe '::build(params:)' do
    let!(:tags) do
      {
        '1' => create(:tag),
        '2' => create(:tag)
      }
    end

    # paramsの準備(データの定義)
    let(:params) do
      {
        title: 'memo',
        content: 'メモ',
        tags: [
          { tag_id: tags['1'].id },
          { tag_id: tags['2'].id }
        ]
      }
    end

    it '返り値がMemo::CreateFormで、メモとメモタグがbuildされること' do
      aggregate_failures do
        result = described_class.build(params)

        # 返り値の検証:
        expect(result.class).to eq(described_class)

        # メモがbuildされたことの検証:
        expect(result.memo.class).to eq(Memo)
        expect(result.memo.title).to eq(params[:title])
        expect(result.memo.content).to eq(params[:content])

        # メモのタグがbuildされたことの検証:
        expect(result.memo_tags.class).to eq(Array)
        result.memo_tags.each do |memo_tag|
          expect(memo_tag.class).to eq(MemoTag)
        end
      end
    end
  end

  describe '#save' do
    # paramsの準備(データの定義)
    let(:params) do
      {
        title: 'memo',
        content: 'メモ',
        tags: [
          { tag_id: tags['1'].id },
          { tag_id: tags['2'].id }
        ]
      }
    end
    let!(:tags) do
      {
        '1' => create(:tag),
        '2' => create(:tag)
      }
    end

    context 'バリデーションエラーになる時' do
      let!(:tags) do
        {
          '1' => create(:tag),
          '2' => create(:tag)
        }
      end

      # paramsの準備(データの定義)
      let(:params) do
        {
          title: '',
          content: '',
          tags: [
            { tag_id: tags['1'].id },
            { tag_id: tags['2'].id }
          ]
        }
      end

      it 'メモとメモタグが保存されないこと' do
        aggregate_failures do
          form = described_class.build(params)
          expect(form.save).to be_falsey
        end
      end
    end

    it 'メモとメモタグが保存されること' do
      aggregate_failures do
        form = described_class.build(params)

        # 返り値の検証:
        expect(form.save).to be_truthy

        # メモがbuildされたことの検証:
        created_memo = Memo.find_by(title: params[:title], content: params[:content])
        expect(created_memo).to be_present

        # メモのタグがbuildされたことの検証
        params[:tags].each do |tag|
          memo_tag = MemoTag.find_by(memo_id: created_memo.id, tag_id: tag[:tag_id])
          expect(memo_tag).to be_present
        end
      end
    end
  end
end
