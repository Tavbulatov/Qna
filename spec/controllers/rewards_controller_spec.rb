require 'rails_helper'

RSpec.describe RewardsController, type: :controller do

  describe "GET #show" do
    let(:question) { create(:question) }
    let(:reward) { create(:reward, question: question)}

    before {get :show, params: {id: reward}}

    it "assigning a variable to view the reward" do
      expect(assigns(:reward)).to eq(reward)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
