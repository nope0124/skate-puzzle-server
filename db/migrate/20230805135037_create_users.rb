class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :hash_id, null: false
      t.string :name, null: false, default: "NONAME"
      t.timestamps
    end
  end
end
