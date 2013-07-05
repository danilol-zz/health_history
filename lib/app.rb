# -*- encoding : utf-8 -*-
class HealthHistory::App < Sinatra::Base
  get '/' do

    rels = [
      { rel: 'hi', href: '/user/hi' },
    ]
    { health_history: rels }.to_json
  end

end
