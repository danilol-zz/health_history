# -*- encoding : utf-8 -*-
module HttpStatusCodes
  def ok
    status 200
  end

  def created(location)
    headers['Location'] = location
    status 201
  end

  def conflict(message = nil)
    halt 409, jsonify_message(message)
  end

  def bad_request(message = nil)
    halt 400, jsonify_message(message)
  end

  def not_authorized(message = nil)
    halt 401, jsonify_message(message)
  end

  def unprocessable_entity(message = nil)
    halt 422, jsonify_message(message)
  end

  def not_found(message = nil)
    halt 404, jsonify_message(message)
  end

  def no_content(location)
    headers['Location'] = location
    status 204
  end

  private

  def jsonify_message(message)
    (message || { error: 'No error message given'} ).to_json
  end

end
