class Section < ApplicationRecord
    belongs_to :course

    has_many :contents, -> { order(position: :asc) }
    has_many :videos, through: :contents, source: :contentable, source_type: 'Video'
    has_many :powerpoints, through: :contents, source: :contentable, source_type: 'Powerpoint'
    has_many :videos, through: :contents, source: :contentable, source_type: 'Video'
    has_many :exercises, through: :contents, source: :contentable, source_type: 'Exercise'
end
