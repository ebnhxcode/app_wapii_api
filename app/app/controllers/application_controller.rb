class ApplicationController < ActionController::API

  def parse_json(json)
    JSON.parse(json)
  rescue JSON::ParserError => e
    Rails.logger.error "No se pudo generar parse_json de la respuesta."
    Rails.logger.error(e)
    {}
  end



end
