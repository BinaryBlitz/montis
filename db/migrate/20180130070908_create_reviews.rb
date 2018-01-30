class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :content, null: false
      t.boolean :approved, default: false
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
