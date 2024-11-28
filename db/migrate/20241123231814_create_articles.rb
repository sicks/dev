class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.references :author
      t.string :title
      t.text :markdown
      t.text :html
      t.datetime :published_at

      t.timestamps
    end
  end
end
