class User < ApplicationRecord
    has_many :user_stage_progresses
    has_many :stages, dependent: :destroy, through: :user_stage_progresses
end
