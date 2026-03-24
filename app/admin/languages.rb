# frozen_string_literal: true

ActiveAdmin.register Language do
  permit_params :name, :level
end
