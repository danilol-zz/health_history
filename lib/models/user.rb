# -*- encoding : utf-8 -*-
class HealthHistory::User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,  type: String
  field :email, type: String
  field :cpf,   type: String
  field :dob,   type: Date

  validates :name, uniqueness: true, presence: true, length:  { maximum: 100 }
  validates :email, uniqueness: true, presence: true, length:  { maximum: 80 }

  def href
    "/user/#{self.id}"
  end

  def already_exists?
    invalid? && (errors[:email].include?('is already taken') || errors[:name].include?('is already taken'))
  end
end
