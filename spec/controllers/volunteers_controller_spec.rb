require 'rails_helper'

describe VolunteersController, type: :controller do
  describe 'GET #index' do

    it "populates an array of volunteers ordered by created_at DESC" do
      organizations = create_list(:organization, 2)
      volunteers_example = create_list(:volunteer, 2)
      volunteer_3 = create(:volunteer, organization_id: organizations[0].id)
      volunteer_4 = create(:volunteer, organization_id: organizations[0].id)
      volunteer_5 = create(:volunteer, organization_id: organizations[1].id)
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