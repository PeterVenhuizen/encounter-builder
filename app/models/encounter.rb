class Encounter < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :monsters, presence: { message: 'the encounter should have at least one' }
end
