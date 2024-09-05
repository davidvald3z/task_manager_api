class Movement < ApplicationRecord
    validates :description, presence: true

    belongs_to :branch
end
