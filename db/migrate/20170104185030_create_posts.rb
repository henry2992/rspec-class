class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :author
      t.text :text
      t.belongs_to :category
      t.timestamps
    end
  end
end
