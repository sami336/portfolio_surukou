class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :tag_id
      t.string  :image_book
      t.string  :title
      t.text    :body

      t.timestamps
    end
  end
end
