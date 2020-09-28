require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before do
    setup_application_instance
  end

  context "not logged in" do
    describe "GET index" do
      it "redirects to sign in" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "as user" do
    login_user

    let(:other_user) { FactoryBot.create(:signed_up_user) }

    describe "GET index" do
      it "returns forbidden" do
        get :index
        expect(response).to have_http_status(403)
      end
    end

    describe "GET show" do
      it "returns forbidden" do
        params = {
          id: other_user.id,
        }
        get :show, params: params
        expect(response).to have_http_status(403)
      end
    end

    describe "GET edit" do
      it "returns forbidden" do
        params = {
          id: other_user.id,
        }
        get :edit, params: params
        expect(response).to have_http_status(403)
      end
    end

    describe "PATCH update" do
      it "returns forbidden" do
        params = {
          id: other_user.id,
          user: {
            role_ids: [],
          },
        }
        patch :update, params: params
        expect(response).to have_http_status(403)
      end
    end

    describe "DELETE destroy" do
      it "returns forbidden" do
        params = {
          id: other_user.id,
        }
        delete :destroy, params: params
        expect(response).to have_http_status(403)
      end
    end
  end

  context "as admin" do
    login_admin

    let!(:other_user1) { FactoryBot.create(:signed_up_user) }
    let!(:other_user2) { FactoryBot.create(:signed_up_user) }
    let!(:other_user3) { FactoryBot.create(:user_canvas) }

    describe "GET index" do
      it "is successful" do
        get :index
        expect(response).to have_http_status(200)
      end

      it "loads sign_up users" do
        get :index
        expect(assigns(:users)).to include(@admin)
        expect(assigns(:users)).to include(other_user1)
        expect(assigns(:users)).to include(other_user2)
        expect(assigns(:users)).to_not include(other_user3)
      end
    end

    describe "GET show" do
      it "is successful" do
        params = {
          id: other_user1.id,
        }
        get :show, params: params
        expect(response).to have_http_status(200)
      end

      it "loads sign_up users" do
        params = {
          id: other_user1.id,
        }
        get :show, params: params
        expect(assigns(:user)).to eq(other_user1)
      end
    end

    describe "GET edit" do
      it "is successful" do
        params = {
          id: other_user1.id,
        }
        get :edit, params: params
        expect(response).to have_http_status(200)
      end

      it "loads sign_up users" do
        params = {
          id: other_user1.id,
        }
        get :edit, params: params
        expect(assigns(:user)).to eq(other_user1)
      end
    end

    describe "PATCH update" do
      it "is successful" do
        padawan_role = FactoryBot.create(:role, name: "padawan")
        params = {
          id: other_user1.id,
          user: {
            role_ids: ["", padawan_role.id],
          },
        }
        patch :update, params: params
        expect(response).to have_http_status(302)
        other_user1.reload
        expect(other_user1.roles).to include(padawan_role)
      end
    end

    describe "DELETE destroy" do
      it "is successful" do
        params = {
          id: other_user1.id,
        }
        expect do
          delete :destroy, params: params
        end.to change { User.count }.by(-1)
      end
    end
  end
end
