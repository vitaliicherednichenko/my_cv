# frozen_string_literal: true

class CvsController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
    @experiences = @profile.experiences.includes(:experience_items).order(start_date: :desc)
    @skills = @profile.skills
    @languages = @profile.languages
    @educations = @profile.educations
    @certificates = @profile.certificates
    @projects = @profile.projects

    respond_show
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update(profile_params)
      redirect_to cv_path(params[:id]), notice: 'Updated successfully'
    else
      render :show
    end
  end

  private

  def respond_show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = CvPdf.new(@profile)
        send_data pdf.render, filename: 'cv.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def profile_params # rubocop:disable Metrics/MethodLength
    params.require(:profile).permit(
      :full_name, :title, :summary, :phone, :email, :location, :github_url, :linkedin_url,
      skills_attributes: %i[id name level _destroy], languages_attributes: %i[id name level _destroy],
      educations_attributes: %i[id degree institution location start_date end_date _destroy],
      certificates_attributes: %i[id name provider issue_date _destroy],
      projects_attributes: %i[id name description github_url live_url _destroy],

      experiences_attributes: [:id, :position, :company_name, :location, :start_date, :end_date, :current, :_destroy,
                               { experience_items_attributes: %i[id content _destroy] }],
      header_style_attributes: %i[id bg_color text_color font_size bold],
      sidebar_style_attributes: %i[id bg_color text_color font_size bold width],
      main_style_attributes: %i[id bg_color text_color font_size bold]
    )
  end
end
