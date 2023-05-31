require 'rails_helper'

RSpec.describe RewardsController, type: :controller do
  let(:question) { create(:question) }

  describe "GET #show" do

    let(:reward) { create(:reward, question: question)}

    before {get :show, params: {id: reward}}

    it "assigning a variable to view the reward" do
      expect(assigns(:reward)).to eq(reward)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:rewards) { create_list(:reward, 3, question: question, user: user)}

    before do
      login(user)
      get :index
    end

    it 'setting @user_rewards variable for all user rewards' do
      expect(assigns(:user_rewards)).to eq(rewards)
    end

    it 'render view index' do
      expect(response).to render_template :index
    end
  end
end
