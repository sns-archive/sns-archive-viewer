# frozen_string_literal: true

class MemosController < ApplicationController
  # GET /memos
  def index
    memos = Memo::Query.resolve(memos: Memo.all, params: params)
    render json: { memos: memos }, status: :ok
  end

  # GET /memos/:id
  def show
    @memo = Memo.find(params[:id])
    @comments = @memo.comments.order(id: 'DESC')
    render 'show', status: :ok
  end

  # POST /memos
  def create
    form = Memo::CreateForm.build(memo_params)
    if form.save
      head :no_content
    else
      render json: { messages: form.errors.full_messages }, status: :unprocessable_content
    end
  end

  # PUT /memos/:id
  # レスポンスが違うって、ことはコントローラーそうに問題がありそう
  # 最短でデバッグできてそうかを考える
  # エラーを確認した際に、バリデーションエラーがあったら、その項目を触っている触っている箇所を確認しよう
  def update
    form = Memo::UpdateForm.build(update_memo_params, params[:id])
    if form.save
      head(:no_content)
    else
      render(
        json: { messages: form.errors.full_messages },
        # ググる
        status: :unprocessable_entity
      )
    end
  end

  # DELETE /memos/:id
  def destroy
    memo = Memo.find(params[:id])
    memo.destroy
    head :no_content
  end

  private

  def memo_params
    # e.g. params: { memo: { title: 'タイトル', content: 'メモ', tags: [{ tag_id: 1},] } }
    params.require(:memo).permit(:title, :content, tags: [{}])
  end

  def update_memo_params
    params.require(:memo).permit(:content)
  end
end
