require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let!(:link) { create(:link, linkable: question) }

  describe 'POST #destroy' do
    before { login(user) }

    context 'destruction by the author of the link' do
      it 'destroy link' do
        expect { delete :destroy, params: { id: link}, format: :js }.to change(Link, :count).by(-1)
      end
    end

    context 'removal of link by link author' do
      before { delete :destroy, params: { id: link}, format: :js }

      it 'render destroy view' do
        expect(response).to render_template :destroy
      end

      it 'sets a flash message' do
        expect(flash[:notice]).to eq('Your link has been successfully deleted')
      end
    end

    context 'link removed by non-author' do
      let(:other_user) { create(:user) }

      before { login(other_user) }

      it 'destroy link' do
        expect {delete :destroy, params: { id: link}, format: :js}.to change(Link, :count).by(0)
      end

      before { delete :destroy, params: { id: link}, format: :js }

      it 'render destroy view' do
        expect(response).to render_template :destroy
      end

      it 'sets a flash message' do
        expect(flash[:alert]).to eq("You can't delete someone else's link")
      end
    end
  end
end
