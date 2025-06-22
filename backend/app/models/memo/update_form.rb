# frozen_string_literal: true

class Memo
  class UpdateForm
    include ActiveModel::Validations

    attr_reader :id, :params

    validates :memo, composite: true

    # @param params [ActionController::Parameters] Controller側でpermitしたパラメータ
    #   @option params [String] :content メモの本文
    # @return [Memo::UpdateForm]
    def self.build(params:, id:)
      new(params, id).tap(&:setup)
    end

    # e.g. params = { memo: { id: 1, content: 'メモ更新' } }
    def initialize(params, id)
      @params = params
      @id = id
    end

    def setup
      memo
    end

    # @return [Boolean] 保存に成功したかどうか
    def save
      return if invalid?

      ActiveRecord::Base.transaction do
        save_record!(memo)
      end

      # @note errorsが空の場合はtrueを返せる。
      errors.empty?
    end

    private

    def memo
      @memo ||= Memo.find(id).tap do |memo|
        memo.content = params[:content] unless params[:content].nil?
      end
    end

    def save_record!(record)
      return if record.invalid? || record.save

      errors.add(:base, record.errors.full_messages.to_sentence)
      raise ActiveRecord::Rollback
    end
  end
end
