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
end
