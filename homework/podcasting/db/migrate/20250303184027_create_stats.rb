class CreateStats < ActiveRecord::Migration[8.0]
  def change
    create_table :stats do |t|
      t.references :episode, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
