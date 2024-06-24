# frozen_string_literal: true

class OctokitClientStub
  def self.repository(_user, _repository_id)
    {
      id: 1,
      name: 'rails-project-66',
      full_name: 'SergeShapovalov/rails-project-66',
      language: 'Ruby'
    }
  end

  def self.repositories(_user)
    [
      {
        id: 1,
        name: 'rails-project-66',
        full_name: 'SergeShapovalov/rails-project-66',
        language: 'Ruby'
      }
    ]
  end

  def self.create_hook(_user, _repository)
    {
      id: 1,
      url: Rails.application.routes.url_helpers.api_checks_url,
      content_type: 'json',
      insecure_ssl: 1
    }
  end
end
