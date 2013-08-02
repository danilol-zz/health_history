# -*- encoding : utf-8 -*-                                                                                    |" Press <F1> for help
FactoryGirl.define do
  factory :user, class: HealthHistory::User do
    name    "Maria Antonieta Sousa"
    cpf     "75210981452"
    email   'teste@teste.com.br'
    dob     '11/03/1987'
  end
end
