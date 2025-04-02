# frozen_string_literal: true

class Memo
  class CreateForm
    # indent
    # https://github.com/rubocop/ruby-style-guide?tab=readme-ov-file#empty-lines-around-bodies
    include ActiveModel::Validations

    attr_reader :memo, :memo_tags

    validates :memo, cascade: true
    validates :memo_tags, cascade: true

    # @param params [ActionController::Parameters] Controller側でpermitしたパラメータ
    #   @option params [String] :title メモのタイトル
    #   @option params [String] :content メモの本文
    #   @option params [Array<Hash>] :tags 紐付けるタグの情報
    #     @option tags [Integer] :tag_id タグのID
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

    # @note このメソッド内でMemoと関連付いているレコードを保存する
    # @return [Boolean] 保存に成功したかどうか
    def save
      return false unless valid?

      ActiveRecord::Base.transaction do
        save_record!(@memo)
        @memo_tags.each { save_record!(_1) }
      end

      # @note errorsが空の場合はtrueを返せる。
      errors.empty?
    end

    # @param record [ApplicationRecord] ActiveRecordのモデルインスタンス
    def save_record!(record)
      return if record.nil? || record.save

      errors.add(:base, record.errors.full_messages.to_sentence)
      raise ActiveRecord::Rollback
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
