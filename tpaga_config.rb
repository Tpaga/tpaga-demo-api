require 'tpaga'

Tpaga::Swagger.configure do |config|
  config.scheme = 'https'
  config.host = 'sandbox.tpaga.co'
  config.base_path = '/api'
  config.inject_format = false
  config.api_key = 'd13fr8n7vhvkuch3lq2ds5qhjnd2pdd2'
end
