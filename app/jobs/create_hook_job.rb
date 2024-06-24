# frozen_string_literal: true

class CreateHookJob < ApplicationJob
  queue_as :default

  def perform(user, repository)
    ApplicationContainer[:octokit_client].create_hook(user, repository)
  rescue StandardError
    'Hook already exists on this repository'
    # See: https://docs.github.com/rest/repos/webhooks#create-a-repository-webhook
  end
end
