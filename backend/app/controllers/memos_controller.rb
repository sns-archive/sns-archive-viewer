class MemosController < ApplicationController
    def create
        memo = Memo.new(memo_params)
        # 成功した場合ステータスコードのみ返す
        if memo.save
            head :no_content
            # 入力値が空の場合エラーメッセージをJSONで返す
          else
            render json: { errors: memo.errors.full_messages }, status: :unprocessable_entity 
          end
    end

    private
    def memo_params
        params.require(:memo).permit( :title, :content)
    end
end
