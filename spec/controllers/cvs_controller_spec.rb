# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CvsController, type: :controller do
  let!(:profile) { create(:profile) }

  describe 'GET #index' do
    it 'assigns all profiles to @profiles' do
      get :index

      expect(assigns(:profiles)).to eq([profile])
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    context 'HTML format' do
      it 'assigns the requested profile and associated records' do
        experience = create(:experience, profile: profile)
        skill = create(:skill, profile: profile)
        language = create(:language, profile: profile)
        education = create(:education, profile: profile)
        certificate = create(:certificate, profile: profile)
        project = create(:project, profile: profile)

        get :show, params: { id: profile.id }, format: :html

        expect(assigns(:profile)).to eq(profile)
        expect(assigns(:experiences)).to include(experience)
        expect(assigns(:skills)).to include(skill)
        expect(assigns(:languages)).to include(language)
        expect(assigns(:educations)).to include(education)
        expect(assigns(:certificates)).to include(certificate)
        expect(assigns(:projects)).to include(project)
        expect(response).to render_template(:show)
      end
    end

    context 'PDF format' do
      it 'returns a PDF file' do
        pdf_double = instance_double('CvPdf', render: 'PDF_CONTENT')
        allow(CvPdf).to receive(:new).with(profile).and_return(pdf_double)

        get :show, params: { id: profile.id }, format: :pdf

        expect(response.content_type).to eq('application/pdf')
        expect(response.body).to eq('PDF_CONTENT')
        expect(response.headers['Content-Disposition']).to include('inline')
      end
    end
  end
end
