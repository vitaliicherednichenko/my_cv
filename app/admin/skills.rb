# frozen_string_literal: true

ActiveAdmin.register Skill do
  permit_params :name, :level, :category

  index do
    selectable_column
    id_column
    column :name
    column :level
    column :category
    actions
  end
end
