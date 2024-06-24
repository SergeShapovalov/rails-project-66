# frozen_string_literal: true

class CreateHookJob < ApplicationJob
  queue_as :default

  def perform(user, repository)
    ApplicationContainer[:octokit_client].create_hook(user, repository)
  end
end
