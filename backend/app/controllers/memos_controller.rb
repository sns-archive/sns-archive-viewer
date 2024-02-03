# frozen_string_literal: true

class MemosController < ApplicationController
  before_action :find_memo, only: %i[show update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /memos
  def index
    memos = Memo.all
    render json: { memos: memos }, status: :ok
  end

  # GET /memos/:id
  def show
    render json: { memo: @memo }, status: :ok
  end

  # POST /memos
  def create
    memo = Memo.new(memo_params)
    if memo.save
      head :no_content
    else
      render json: { errors: memo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /memos/:id
  def update
    if @memo.update(update_memo_params)
      head :no_content
    else
      render json: { errors: @memo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /memos/:id
  def destroy
    @memo.destroy
    head :no_content
  end

  private

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def find_memo
    @memo = Memo.find(params[:id])
  end

  def memo_params
    params.require(:memo).permit(:title, :content)
  end

  def update_memo_params
    params.require(:memo).permit(:content)
  end
end
