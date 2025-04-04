# frozen_string_literal: true
class Memo
  class UpdateForm
    include ActiveModel::Validations

    attr_accessor :memo

    validates :memo, cascade: true

    # @param params [ActionController::Parameters] Controller側でpermitしたパラメータ
    #   @option params [String] :content メモの本文
    # @return [Memo::UpdateForm]
    def self.build(params,id)
      new(params, id).tap(&:setup)
    end

    # e.g. params = { memo: { id: 1, content: 'メモ更新' } }
    def initialize(params,id)
      @params = params
      @id = id
    end

    def setup
      @memo = Memo.find(@id)
      unless @params[:content].nil?
        @memo.content = @params[:content]
      end
    end

    # @return [Boolean] 保存に成功したかどうか
    def save
      if valid?
        @memo.save
      else
        false
      end
    end
  end
end
