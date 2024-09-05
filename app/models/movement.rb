class Movement < ApplicationRecord
    validates :description, presence: true

    belongs_to :branch

    scope :sales, -> { where("movement_type='I'") }
    scope :expenses, -> { where("movement_type='E'") }
end
