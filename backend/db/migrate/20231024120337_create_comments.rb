class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :memo, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
