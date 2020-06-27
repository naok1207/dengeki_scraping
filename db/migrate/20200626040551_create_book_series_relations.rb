class CreateBookSeriesRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :book_series_relations do |t|
      t.references :book, null: false, foreign_key: true
      t.references :series, null: false, foreign_key: true

      t.timestamps
    end
  end
end
