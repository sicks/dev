class CreateArticleVeneers < ActiveRecord::Migration[8.0]
  def change
    create_table :article_veneers do |t|
      t.references :article, null: false, foreign_key: true
      t.references :veneer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
