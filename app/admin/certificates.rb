# frozen_string_literal: true

ActiveAdmin.register Certificate do
  permit_params :name, :provider, :issue_date
end
