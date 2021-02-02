# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let(:todos) { create_list(:todo, 10) }
  let(:todo) { Todo.first }

  describe 'GET /todos' do
    before { get api_todos_path }

    it 'returns status code 200' do
      expect(response).to(have_http_status(:ok))
    end
  end
end
