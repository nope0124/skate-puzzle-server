class Stage < ApplicationRecord
    has_many :user_stage_progresses
    has_many :users, dependent: :destroy, through: :user_stage_progresses
end
