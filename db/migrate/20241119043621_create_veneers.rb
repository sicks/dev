class CreateVeneers < ActiveRecord::Migration[8.0]
  def change
    create_table :veneers do |t|
      t.string :host, index: { unique: true }
      t.string :title, null: false, default: "website/name"
      t.string :subtitle, null: false, default: "this is a website"
      t.string :theme, null: false, default: "dark"

      t.timestamps
    end
  end
end
