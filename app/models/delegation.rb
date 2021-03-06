class Delegation < ApplicationRecord
  belongs_to :camp
  belongs_to :supervisor, required: false

  has_many :participants

  validates :max_teams, numericality: { greater_than: 0 }
end
