class UserStageProgress < ApplicationRecord
    belongs_to :user
    belongs_to :stage
end
