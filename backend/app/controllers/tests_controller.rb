# frozen_string_literal: true

class TestsController < ApplicationController
  # TODO: 動作確認用のコードなので、実際にAPIが作成されたら削除する
  # 対応するissue: https://github.com/Progaku-copy/progaku-archive/issues/5
  def index
    render json: { key: 'Hello World!' }
  end
end
