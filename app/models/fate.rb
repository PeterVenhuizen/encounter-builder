class Fate < ApplicationRecord
  belongs_to :encounter
  belongs_to :monster

  validates :group_size,
            numericality: { greater_than: 0 }
end
