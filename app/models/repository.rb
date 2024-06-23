class Repository < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :checks, class_name: 'Repository::Check'

  enumerize :language, in: %w[ruby]

  validates :github_id, uniqueness: true, presence: true
end
