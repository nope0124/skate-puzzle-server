class CreateUserStageProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :user_stage_progresses do |t|
      t.integer :user_id, null: false
      t.integer :stage_id, null: false
      t.integer :progress, null: false, default: 0
      t.timestamps
    end
  end
end
