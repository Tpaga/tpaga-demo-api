require 'grape'
require './tpaga_config.rb'
require 'tpaga'
module TpagaDemo
  class API < Grape::API

    format :json

    rescue_from Tpaga::ClientError do |e|
      error!('Error', 500)
    end

    get '/user/:id' do
      Tpaga::CustomerApi.get_customer_by_id(params[:id]).to_hash
    end

    post '/user' do

      params do
        requires :firstName, type: String
        requires :lastName, type: String
        requires :email, type: String
        requires :phone, type: String
      end

      customer = Tpaga::Customer.new(firstName: params[:firstName], lastName: params[:lastName],
      email: params[:email], phone: params[:phone])
      customer = Tpaga::CustomerApi.create_customer(customer)
      p customer
      customer.to_hash
    end

  end
end
