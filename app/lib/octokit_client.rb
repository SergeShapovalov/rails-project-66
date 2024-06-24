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
      .filter { |repository| repository[:language].downcase == 'ruby' }
  end

  def self.create_hook(user, repository)
    client(user).create_hook(
      repository.github_id,
      'web',
      {
        url: Rails.application.routes.url_helpers.api_checks_url,
        content_type: 'json',
        insecure_ssl: 1
      }
    )
  end
end
