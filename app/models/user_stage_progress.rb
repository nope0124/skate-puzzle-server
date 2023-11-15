class UserStageProgress < ApplicationRecord
  belongs_to :user
  belongs_to :stage

  validates_uniqueness_of :user_id, scope: :stage_id
end
