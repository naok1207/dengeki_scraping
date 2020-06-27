class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :number
      t.string :author
      t.string :illustrator
      t.string :subtitle
      t.text :detail
      t.bigint :isbn
      t.string :format
      t.integer :page
      t.datetime :release
      t.integer :price
      t.string :publisher
      t.string :url
      t.string :image
      t.references :series, foreign_key: true

      t.timestamps
    end
  end
end
