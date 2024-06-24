# frozen_string_literal: true

class OctokitClient
  def self.client(user)
    client = Octokit::Client.new(access_token: user.token)
    client.auto_paginate = true
    client
  end

  def self.repository(user, repository)
    client(user).repository(repository.github_id)
  end

  def self.repositories(user)
    client(user)
      .repositories(user.nickname)
      .filter { |repository| %w[ruby javascript].include?(repository[:language].downcase) }
  end

  def self.create_hook(user, repository)
    client(user).create_hook(
      repository.full_name,
      'web',
      { url: "#{ENV.fetch('BASE_URL', nil)}/api/checks", content_type: 'json' },
      { events: %w[push], active: true }
    )
  end
end
