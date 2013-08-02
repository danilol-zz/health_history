# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HealthHistory::Controllers::UserController do
  #it_should_behave_like 'an etag', :user, '/user/:id'
  context 'create' do

    subject { last_response }

    context 'failure' do
      context 'validation error' do
        context 'fail when no params was sent' do
          before { post '/user' }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":\"Bad request. Body is blank.\"}" }
        end

        context 'fails when a required field was not sent' do
          let(:user_params) { { email: 'danilo@eu.com', cpf: '341.213.888-60', dob: '11/03/1987' } }

          before { post '/user', user_params.to_json }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":{\"name\":[\"can't be blank\"]}}" }
        end

        context 'fails when a required field was sent with nil value' do
          let(:user_params) { { name: 'Danilo Lima', email: nil, cpf: '341.213.888-60', dob: '11/03/1987' } }

          before { post '/user', user_params.to_json }

          its(:status) { should eq 400 }
          its(:body)   { should eq "{\"errors\":{\"email\":[\"can't be blank\"]}}" }
        end
      end
    end

    context 'success' do
      context 'creates the user with required parameters only' do
        let(:user_params) { { name: 'danilo lima', email: 'danilo@eu.com' } }

        before { post '/user', user_params.to_json }

        its(:status) { should eq 201 }
        its(:body)   { should be_empty }

        it 'should return the user href' do
          user = HealthHistory::User.find_by(email: user_params[:email])
          expect(user.name).to  eq user_params[:name]
          expect(user.email).to eq user_params[:email]
          expect(user.cpf).to be_nil
          expect(user.dob).to be_nil
          expect(subject.headers["Location"]).to eq "/user/#{user.id}"
        end
      end

      context 'creates the user with all parameters' do
        let(:user_params) { { name: 'danilo lima', email: 'danilo@eu.com', cpf: '341.213.888-60', dob: '11/03/1987' } }

        before { post '/user', user_params.to_json }

        its(:status) { should eq 201 }
        its(:body)   { should be_empty }

        it 'should return the user href' do
          user = HealthHistory::User.find_by(email: user_params[:email])
          expect(user.name).to  eq user_params[:name]
          expect(user.email).to eq user_params[:email]
          expect(user.cpf).to eq user_params[:cpf]
          expect(user.dob.strftime("%d/%m/%Y")).to eq user_params[:dob]
          expect(subject.headers["Location"]).to eq "/user/#{user.id}"
        end
      end
    end
  end

  #context 'create' do
    #it "should save a complete user" do
      #user = FactoryGirl.attributes_for :user, address: FactoryGirl.attributes_for(:address)
      #post '/user', user.to_json
      #last_response.status.should == 201

      #get last_response['location']
      #last_response.should be_ok

      #saved_user = JSON.parse(last_response.body)['resource']

      #saved_user['name'].should == user[:name]
      #saved_user['email'].should == user[:email]
      #saved_user['cpf'].should == user[:cpf]

      #[:street_line1, :street_line2, :street_number, :neighbourhood, :postal_code, :city, :state].each do |field|
        #saved_user['address'][field.to_s].should == user[:address][field]
      #end
    #end

    #it 'should save an ess imported user' do
      #imported_data = {
        #gender: 'M',
        #rg: '1234567890',
        #inscricao_estadual: '1234567890',
        #user_type: 'F',
        #date_of_birth: '28/02/1986',
        #phone_number_area_code: '51',
        #phone_number: '1234-5678',
        #branch_line_number: '51',
        #cellphone_number: '12345-6789',
        #deactivated: false,
        #deactivation_date: DateTime.parse('2012/06/06').to_s,
        #last_version_id: '1',
        #version: '1',
        #created_at: DateTime.parse('2012/06/06').to_s,
        #updated_at: DateTime.parse('2012/06/06').to_s
      #}

      #user = FactoryGirl.attributes_for(:user, {
        #address: FactoryGirl.attributes_for(:address),
        #external_id: 'ess_user_id',
        #ess_imported_data: imported_data
      #})

      #post '/user', user.to_json
      #last_response.status.should == 201

      #get last_response['location']
      #last_response.should be_ok

      #saved_user = JSON.parse(last_response.body)['resource']
      #saved_user['external_id'].should == 'ess_user_id'
      #imported_data.keys.each do |field|
        #saved_user['ess_imported_data'][field.to_s].should == user[:ess_imported_data][field]
      #end
    #end

    #it "should save salt when importing user from iba1" do
      #user = FactoryGirl.attributes_for :user, salt: 'salt_from_iba_one', ess_imported_data: { gender: 'M' }

      #post '/user', user.to_json

      #last_response.status.should == 201

      #Profiles::User.last.salt.should == 'salt_from_iba_one'
    #end

    #it "should not save the card for complete user" do
      #user = FactoryGirl.attributes_for :user, address: FactoryGirl.attributes_for(:address), card: FactoryGirl.build(:card)
      #post '/user', user.to_json
      #last_response.status.should == 201

      #Profiles::User.last.card.should be_nil
    #end

    #context 'with errors on the mongo model' do
      #it "should return the model errors if any" do
        #user_attributes = FactoryGirl.attributes_for(:adult_user, password: 'f')

        #post '/user', user_attributes.to_json
        #last_response.status.should == 422

        #response_hash = JSON.parse(last_response.body)

        #returned_user = response_hash['resource']
        #returned_user['errors']['password'].should == ["A senha deve conter pelo menos 8 (oito) caracteres, incluindo letras, números e caracteres especiais tais como #, !, @"]
        #returned_user['password'].should == nil
      #end
    #end

    #context 'with errors on the client model' do
      #it "should return the model errors if any" do
        #user_attributes = FactoryGirl.attributes_for(:adult_user)
        #user_attributes[:name] = nil

        #post '/user', user_attributes.to_json
        #last_response.status.should == 422

        #response_hash = JSON.parse(last_response.body)
        #returned_user = response_hash['resource']

        #returned_user['errors']['name'].should_not be_nil
        #returned_user['errors']['name'].should_not be_empty
      #end
    #end

    #it "should use only user properties to create a new User" do
      #user_attributes = FactoryGirl.attributes_for(:user)

      #post '/user', user_attributes.to_json

      #user = Profiles::User.last
      #last_response.status.should == 201
      #last_response.location.should == "/user/#{user._id}"

      #last_response.body.should be_empty
    #end

    #it 'should respond with a 422 if no user params are provided' do
      #post '/user', {}.to_json
      #last_response.status.should == 422
    #end

    #context 'external_id duplication' do
      #it 'should return a 409 if a user is imported with existing external id' do
        #Profiles.config.redis.set(:last_ess_user_id, 1)
        #user = FactoryGirl.create(:user, name: 'Booga Booga',external_id: '100')
        #another_user = FactoryGirl.attributes_for(:user, name: 'Yola ola',external_id: '100')

        #post '/user', another_user.to_json
        #last_response.status.should == 409
        #last_response.body.should == {errors: I18n.t('external_id.present')}.to_json
        #Profiles.config.redis.get(:last_ess_user_id).should == "1"
      #end
    #end
  #end
  def app
    Rack::URLMap.new HealthHistory.route_map
  end
end
