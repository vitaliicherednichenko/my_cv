# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :cvs, only: %i[index show]

  root 'cvs#index'
end
