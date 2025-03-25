# frozen_string_literal: true

class Memo
  class CreateForm
    # indent
    # https://github.com/rubocop/ruby-style-guide?tab=readme-ov-file#empty-lines-around-bodies
    include ActiveModel::Validations
    attr_reader :memo, :memo_tags

    validates :memo, cascade: true
    validates :memo_tags, cascade: true

    # @return [Memo::CreateForm]
    def self.build(params)
      new(params).tap(&:setup)
    end

    # e.g. params = { memo: { title: 'memo', content: 'メモ',tags: [{tag_id:1},] } }
    def initialize(params)
      @params = params
    end

    def setup
      build_memo
      build_memo_tags
    end

    def save
      return false unless valid?
      ActiveRecord::Base.transaction do
        @memo.save!
        @memo_tags.each(&:save!)
      end
      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
      false
    end

    private

    def build_memo
      @memo = Memo.new(
        title: @params[:title],
        content: @params[:content]
      )
    end

    def build_memo_tags
      tag_ids = @params[:tags]&.map { |tag| tag[:tag_id] } || []
      tags = Tag.where(id: tag_ids)
      @memo_tags = tags.map { |tag| MemoTag.new(memo: @memo, tag: tag) }
    end
  end
end
