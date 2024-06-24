# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(user, check)
    check.run_check!

    linter_result = run_lint(user, check)

    email = :passed_check_email
    status = :finish!
    email_vars = {}

    if linter_result[:is_fatal]
      status = :fail!
      email = :failed_check_email
    elsif linter_result[:offense_count].positive?
      email = :error_check_email
    else
      email_vars = { passed: true }
    end

    check.update(email_vars.merge(details: linter_result))
    check.public_send(status)

    send_email(email, user, check.repository)
  end

  private

  def run_lint(user, check)
    octokit = ApplicationContainer[:octokit_client]

    repository = check.repository
    check.update(commit_id: octokit.get_latest_commit_sha(user, repository))
    dir_path = octokit.clone_repository(user, repository)

    linter = Linters::Handler.new(repository)
    result = linter.exec(dir_path)
    FileUtils.rm_rf(dir_path)

    result
  end

  def send_email(email, user, repository)
    CheckResultMailer
      .with(user_id: user.id, repository_id: repository.id)
      .public_send(email)
      .deliver_later
  end
end
