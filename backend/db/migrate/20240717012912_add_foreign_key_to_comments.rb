class AddForeignKeyToComments < ActiveRecord::Migration[7.0]
  def change
    change_column :comments, :memo_id, :bigint
    add_foreign_key :comments, :memos
  end
end
