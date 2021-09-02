class Content < ApplicationRecord
    belongs_to :section
    belongs_to :contentable, :polymorphic => true
end
