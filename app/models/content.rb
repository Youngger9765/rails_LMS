class Content < ApplicationRecord
    belongs_to :section
    acts_as_list scope: :section
    
    belongs_to :contentable, :polymorphic => true
    
end
