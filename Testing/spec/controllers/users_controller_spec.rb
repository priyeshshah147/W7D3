require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    subject (:peter) { User.create!(username: 'Peter', password: 'password')}
    let (:jack) { User.create!(username: 'Jack', password: 'password')}
    
    describe 'GET#new' do
        it "Renders new user template" do
            get :new
            expect(response).to render_template('new')
        end
    end

    describe 'GET#index' do
        it "should show index template" do
            get :index
            expect(response).to render_template('index')
        end
    end

    describe 'POST#create' do

        context 'with valid params' do
            it "it will direct users to index on success" do
                post :create, params: { user: { username: "Bruce", password: "password" }}
                expect(response).to redirect_to(users_url)
            end
            it "will login the user" do
                post :create, params: { user: { username: "Bruce", password: "password" }}
                user = User.find_by_username("Bruce")
                expect(session[:session_token]).to eq(user.session_token)
            end
        end

        context 'with invalid params' do
            it "should show new page" do
                get :new
                expect(response).to render_template('new')
            end
            
        end
    end
end
