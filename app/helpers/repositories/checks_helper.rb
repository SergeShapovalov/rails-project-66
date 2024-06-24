module Repositories::ChecksHelper
  def github_url(check, options = {})
    commit = check.commit_id.slice(..6)
    file_path = options.delete(:file_path)
    link_name = file_path.nil? ? commit : file_path
    commit_path = file_path.nil? ? "/commit/#{commit}" : "/tree/#{commit}/#{file_path}"

    link_to link_name, "https://github.com/#{check.repository.full_name}#{commit_path}", options
  end
end
