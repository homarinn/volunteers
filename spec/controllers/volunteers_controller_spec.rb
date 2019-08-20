require 'rails_helper'

describe VolunteersController, type: :controller do
  describe 'GET #index' do

    it "populates an array of volunteers ordered by created_at DESC" do
      organization_1 = create(:organization)
      organization_2 = create(:organization)
      volunteer_1 = create(:volunteer)
      volunteer_2 = create(:volunteer)
      volunteer_3 = create(:volunteer, organization_id: organization_1.id)
      volunteer_4 = create(:volunteer, organization_id: organization_1.id)
      volunteer_5 = create(:volunteer, organization_id: organization_2.id)
      volunteers = [volunteer_3, volunteer_4, volunteer_5]
      get :index
      expect(assigns(:volunteers)).to match(volunteers.sort{ |a, b| b.created_at <=> a.created_at })
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end