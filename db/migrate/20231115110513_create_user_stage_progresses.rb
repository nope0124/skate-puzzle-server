class CreateUserStageProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :user_stage_progresses do |t|
      t.integer :user_id
      t.integer :stage_id
      t.timestamps
    end
  end
end
