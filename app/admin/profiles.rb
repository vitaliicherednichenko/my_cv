# frozen_string_literal: true

ActiveAdmin.register Profile do
  permit_params :full_name, :title, :phone, :email, :location,
                :summary, :github_url, :linkedin_url

  form do |f|
    f.inputs do
      f.input :full_name
      f.input :title
      f.input :email
      f.input :phone
      f.input :location
      f.input :github_url
      f.input :linkedin_url
      f.input :summary
    end
    f.actions
  end
end
