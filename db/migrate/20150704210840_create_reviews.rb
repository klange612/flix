class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.integr :stars
      t.text :comment
      t.references :movie, index: true

      t.timestamps
    end
  end
end
