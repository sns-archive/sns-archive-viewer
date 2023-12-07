# frozen_string_literal: true

class MemosController < ApplicationController
  # POST /memos
  def create
    memo = Memo.new(memo_params)
    if memo.save
      head :no_content
    else
      render json: { errors: memo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /memes/:id
  def update
    memo = Memo.find(params[:id])
    if memo.update(memo_params)
      head :no_content
    else
      render json: { errors: memo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:title, :content)
  end
end
