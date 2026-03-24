# frozen_string_literal: true

ActiveAdmin.register Education do
  permit_params :institution, :degree, :location, :start_date, :end_date
end
