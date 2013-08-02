# -*- encoding : utf-8 -*-
class HealthHistory::App < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')

  get '/' do
    rels = [
      { rel: 'user', href: '/user', type: 'application/health_history.user+json;charset=utf-8'},
    ]
    { health_history: rels }.to_json

    etag Digest::MD5.hexdigest rels.to_s

    { health_history: rels }.to_json
  end
end
