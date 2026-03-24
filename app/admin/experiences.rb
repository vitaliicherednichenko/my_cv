# frozen_string_literal: true

ActiveAdmin.register Experience do
  permit_params :company_name, :position, :location,
                :start_date, :end_date, :current,
                experience_items_attributes: %i[id content _destroy]

  form do |f|
    f.inputs 'Experience' do
      f.input :company_name
      f.input :position
      f.input :location
      f.input :start_date
      f.input :end_date
      f.input :current
    end

    f.inputs 'Responsibilities' do
      f.has_many :experience_items, allow_destroy: true, new_record: true do |item|
        item.input :content
      end
    end

    f.actions
  end
end
