class CreatePlayStats < ActiveRecord::Migration[8.0]
  def change
    create_table :play_stats do |t|
      t.references :episode, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :poistion

      t.timestamps
    end
  end
end
