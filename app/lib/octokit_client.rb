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
    languages = %w[ruby javascript]

    client(user)
      .repositories(user.nickname)
      .filter { |repository| languages.include?(repository[:language]&.downcase) }
  end

  def self.create_hook(user, repository)
    client(user).create_hook(
      repository.full_name,
      'web',
      { url: "#{ENV.fetch('BASE_URL', nil)}/api/checks", content_type: 'json' },
      { events: %w[push], active: true }
    )
  end

  def self.clone_repository(repository)
    dir_path = Rails.root.join("tmp/project-66/#{repository.id}")

    FileUtils.rm_rf(dir_path)
    system("git clone #{repository.clone_url} #{dir_path}")

    dir_path
  end

  def self.get_latest_commit_sha(user, repository)
    client(user).commits(repository.full_name).first.sha
  end
end
