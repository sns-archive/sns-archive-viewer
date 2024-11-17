# frozen_string_literal: true

# == Schema Information
#
# Table name: memos
#
#  id                    :bigint           not null, primary key
#  content(メモの本文)   :text(65535)      not null
#  title(メモのタイトル) :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class Memo < ApplicationRecord
  validates :title, :content, presence: true
  has_many :comments, dependent: :destroy

  module Query
    FILTERS = %i[
      TitleFilter
      ContentFilter
      OrderFilter
    ].freeze
    private_constant :FILTERS

    # @param memos [ActiveRecord::Relation[Memo]]
    # @param params [ActionController::Parameters]
    # @return [ActiveRecord::Relation[Memo]]
    def self.resolve(memos:, params:)
      FILTERS.reduce(memos) do |memo_scope, filter|
        const_get(filter).resolve(scope: memo_scope, params: params)
      end
    end

    module TitleFilter
      def self.resolve(scope:, params:)
        return scope if params[:title].blank?

        scope.where('title LIKE ?', "%#{params[:title]}%")
      end
    end
    private_constant :TitleFilter

    module ContentFilter
      def self.resolve(scope:, params:)
        return scope if params[:content].blank?

        scope.where('content LIKE ?', "%#{params[:content]}%")
      end
    end
    private_constant :ContentFilter

    module OrderFilter
      DEFAULT_ORDER = 'desc'
      private_constant :DEFAULT_ORDER

      def self.resolve(scope:, params:)
        scope.order(id: params[:order].presence || DEFAULT_ORDER)
      end
    end
    private_constant :OrderFilter
  end
end
