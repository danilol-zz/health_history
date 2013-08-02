# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HealthHistory::User do
  describe "Fields" do
    it { should have_fields(:name, :email, :cpf).of_type(String) }
    it { should have_fields(:dob).of_type(Date) }
  end

  describe 'Validations' do
     it { should validate_presence_of(:name) }
     it { should validate_presence_of(:email) }
     it { should validate_length_of(:name).with_maximum(100) }
     it { should validate_length_of(:email).with_maximum(80) }
     it { should validate_uniqueness_of(:email) }
     it { should validate_uniqueness_of(:name) }
  end

  describe '#href' do
    context 'when id is not blank' do
      let(:user) { FactoryGirl.create(:user) }

      it 'should return the user href' do
        expect(user.href).to eq "/user/#{user.id}"
      end
    end
  end
end
