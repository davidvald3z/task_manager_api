class Branch < ApplicationRecord
    validates :name, presence: true

    has_many :movements
end
