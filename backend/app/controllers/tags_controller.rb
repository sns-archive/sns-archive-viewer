# frozen_string_literal: true

class TagsController < ApplicationController
  # POST /tags
  def create
    tag = Tag.new(tag_params)
    if tag.save
      head :no_content
    else
      render json: { message: tag.errors.full_messages }, status: :unprocessable_content
    end
  end

  # PUT /tags/:id
  def update
    tag = Tag.find(params[:id])

    if tag.update(tag_params)
      head :no_content
    else
      render json: { message: tag.errors.full_messages }, status: :unprocessable_content
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:label, :color, :priority)
  end
end
