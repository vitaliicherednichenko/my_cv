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
end
