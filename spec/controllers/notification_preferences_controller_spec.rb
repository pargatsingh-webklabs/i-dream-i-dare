require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe NotificationPreferencesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # NotificationPreference. As you add validations to NotificationPreference, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # NotificationPreferencesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all notification_preferences as @notification_preferences" do
      notification_preference = NotificationPreference.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:notification_preferences)).to eq([notification_preference])
    end
  end

  describe "GET #show" do
    it "assigns the requested notification_preference as @notification_preference" do
      notification_preference = NotificationPreference.create! valid_attributes
      get :show, {:id => notification_preference.to_param}, valid_session
      expect(assigns(:notification_preference)).to eq(notification_preference)
    end
  end

  describe "GET #new" do
    it "assigns a new notification_preference as @notification_preference" do
      get :new, {}, valid_session
      expect(assigns(:notification_preference)).to be_a_new(NotificationPreference)
    end
  end

  describe "GET #edit" do
    it "assigns the requested notification_preference as @notification_preference" do
      notification_preference = NotificationPreference.create! valid_attributes
      get :edit, {:id => notification_preference.to_param}, valid_session
      expect(assigns(:notification_preference)).to eq(notification_preference)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new NotificationPreference" do
        expect {
          post :create, {:notification_preference => valid_attributes}, valid_session
        }.to change(NotificationPreference, :count).by(1)
      end

      it "assigns a newly created notification_preference as @notification_preference" do
        post :create, {:notification_preference => valid_attributes}, valid_session
        expect(assigns(:notification_preference)).to be_a(NotificationPreference)
        expect(assigns(:notification_preference)).to be_persisted
      end

      it "redirects to the created notification_preference" do
        post :create, {:notification_preference => valid_attributes}, valid_session
        expect(response).to redirect_to(NotificationPreference.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved notification_preference as @notification_preference" do
        post :create, {:notification_preference => invalid_attributes}, valid_session
        expect(assigns(:notification_preference)).to be_a_new(NotificationPreference)
      end

      it "re-renders the 'new' template" do
        post :create, {:notification_preference => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested notification_preference" do
        notification_preference = NotificationPreference.create! valid_attributes
        put :update, {:id => notification_preference.to_param, :notification_preference => new_attributes}, valid_session
        notification_preference.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested notification_preference as @notification_preference" do
        notification_preference = NotificationPreference.create! valid_attributes
        put :update, {:id => notification_preference.to_param, :notification_preference => valid_attributes}, valid_session
        expect(assigns(:notification_preference)).to eq(notification_preference)
      end

      it "redirects to the notification_preference" do
        notification_preference = NotificationPreference.create! valid_attributes
        put :update, {:id => notification_preference.to_param, :notification_preference => valid_attributes}, valid_session
        expect(response).to redirect_to(notification_preference)
      end
    end

    context "with invalid params" do
      it "assigns the notification_preference as @notification_preference" do
        notification_preference = NotificationPreference.create! valid_attributes
        put :update, {:id => notification_preference.to_param, :notification_preference => invalid_attributes}, valid_session
        expect(assigns(:notification_preference)).to eq(notification_preference)
      end

      it "re-renders the 'edit' template" do
        notification_preference = NotificationPreference.create! valid_attributes
        put :update, {:id => notification_preference.to_param, :notification_preference => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested notification_preference" do
      notification_preference = NotificationPreference.create! valid_attributes
      expect {
        delete :destroy, {:id => notification_preference.to_param}, valid_session
      }.to change(NotificationPreference, :count).by(-1)
    end

    it "redirects to the notification_preferences list" do
      notification_preference = NotificationPreference.create! valid_attributes
      delete :destroy, {:id => notification_preference.to_param}, valid_session
      expect(response).to redirect_to(notification_preferences_url)
    end
  end

end
