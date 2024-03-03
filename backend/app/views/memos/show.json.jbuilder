# frozen_string_literal: true

json.memo do
  json.id @memo.id
  json.title @memo.title
  json.content @memo.content
  json.created_at @memo.created_at
  json.updated_at @memo.updated_at

  json.comments @comments do |comment|
    json.id comment.id
    json.content comment.content
    json.created_at comment.created_at
  end
end
