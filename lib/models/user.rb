# -*- encoding : utf-8 -*-
class HealthHistory::User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,  type: String
  field :email, type: String
  field :cpf,   type: String
  field :dob,   type: Date
end
