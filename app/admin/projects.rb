# frozen_string_literal: true

ActiveAdmin.register Project do
  permit_params :name, :description, :github_url, :live_url
end
