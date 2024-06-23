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
end
