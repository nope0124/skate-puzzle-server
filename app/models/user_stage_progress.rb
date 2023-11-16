class UserStageProgress < ApplicationRecord
  belongs_to :user
  belongs_to :stage

  validates_uniqueness_of :user_id, scope: :stage_id

  validates :progress, inclusion: { in: [0, 1, 2, 3] }
end
