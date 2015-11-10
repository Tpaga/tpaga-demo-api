require 'tpaga'

Tpaga::Swagger.configure do |config|
  config.scheme = 'https'
  config.host = 'sandbox.tpaga.co'
  config.base_path = '/api'
  config.inject_format = false
  config.api_key = ENV["TPAGA_API_KEY"]
end
