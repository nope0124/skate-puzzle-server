class CreateStages < ActiveRecord::Migration[6.1]
  def change
    create_table :stages do |t|
      t.string :board, null: false
      t.timestamps
    end
  end
end
