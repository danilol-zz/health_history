# -*- encoding : utf-8 -*-
class HealthHistory::Controllers::UserController < Sinatra::Base
  include HttpStatusCodes

  post '/' do
    content_type :json
    user_params = parse_json

    halt 400 if user_params.blank?

    user = HealthHistory::User.new(user_params)

    halt 409, {errors: user.errors}.to_json if user.already_exists?
    halt 400, {errors: user.errors}.to_json if user.invalid?

    user.save
    created user.href
  end

  POST_BODY = 'rack.input'.freeze

  def parse_json
    body = env[POST_BODY].read
    halt(400, {errors: 'Bad request. Body is blank.'}.to_json) if body.blank?
    JSON.parse body
  end
end
