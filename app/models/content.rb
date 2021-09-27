class Content < ApplicationRecord
    acts_as_list scope: :section
    belongs_to :section
    belongs_to :contentable, :polymorphic => true
end
