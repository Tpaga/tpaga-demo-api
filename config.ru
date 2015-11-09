require 'rack/cors'

require './tpaga_demo.rb'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

run TpagaDemo::API
