# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HealthHistory::User do
  describe "Fields" do
    it { should have_fields(:name, :email, :cpf).of_type(String) }
    it { should have_fields(:dob).of_type(Date) }
  end
end
