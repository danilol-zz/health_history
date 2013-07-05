# -*- encoding : utf-8 -*-
class HealthHistory::App < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    rels = [
      { rel: 'hi', href: '/users/hi' },
    ]
    { health_history: rels }.to_json
  end
end
