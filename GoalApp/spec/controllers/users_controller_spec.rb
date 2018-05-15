require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'get#new' do
    it 'render the new user\'s template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'post#create' do
    it "log in user with valid params" do
      post :create, params:{user:{username: 'tony',password: 'password'}}
      user = User.find_by(username: 'tony')
      expect(session[:session_token]).to  eq(user.session_token)
    end

    it 'redirects to users index page' do
      post :create, params:{user:{username: 'tony',password: 'password'}}
      user = User.find_by(username: 'tony')
      expect(:response).to redirect_to(users_url)
    end

    it 'with invalid params it will render errors' do
      post :create, params:{user:{username: 'tony',password: ''}}
      expect(:response).to render_template(:new)
      expect(flash[:errors]).to be_present
    end
  end


end
