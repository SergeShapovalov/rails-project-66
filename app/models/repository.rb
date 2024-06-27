# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :checks

  enumerize :language, in: %w[ruby javascript]

  validates :github_id, uniqueness: true, presence: true
end
