# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cvs', type: :request do
  let!(:profile) { create(:profile) }

  describe 'GET /cvs' do
    it 'returns http success' do
      get '/cvs'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /cvs/:id' do
    it 'returns http success' do
      get "/cvs/#{profile.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
