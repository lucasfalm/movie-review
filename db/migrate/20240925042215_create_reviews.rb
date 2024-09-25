class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :score, null: false
      t.references :movie, null: false, foreign_key: { on_delete: :cascade }
      t.integer :category, null: false
      t.timestamps
    end
  end
end
