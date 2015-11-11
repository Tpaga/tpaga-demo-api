require 'grape'
require './tpaga_config.rb'
require 'tpaga'
module TpagaDemo
  class API < Grape::API

    format :json

    rescue_from Tpaga::ClientError do |e|
      p e
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

      customer_local = Tpaga::Customer.new(
        firstName: params[:firstName],
        lastName: params[:lastName],
        email: params[:email],
        phone: params[:phone]
      )      
      customer = Tpaga::CustomerApi.create_customer(customer_local)
      p customer
      customer.to_hash
    end

    post '/card' do
      params do
        requires :cardNumber, type: String
        requires :expMonth, type: String
        requires :expYear, type: String
        requires :cvc, type: String
        requires :cardName, type: String
        requires :userId, type: String
      end
      card_local = Tpaga::CreditCardCreate.new(
          primaryAccountNumber: params[:cardNumber],
          expirationMonth: params[:expMonth],
          expirationYear: params[:expYear],
          cardVerificationCode: params[:cvc],
          cardHolderName: params[:cardName],
          billingAddress: Tpaga::BillingAddress.new
      )
      card = Tpaga::CreditCardApi.add_credit_card(params[:userId], card_local)
      p card
      card.to_hash
    end

    post '/charge' do
      params do
        requires :amount, type: Integer
        requires :iva, type: Integer
        requires :description, type: String
        requires :orderNumber, type: String
        requires :installments, type: Integer
        requires :cardId, type: String
      end
      charge_local = Tpaga::CreditCardCharge.new(
        amount: params[:amount],
        taxAmount: params[:iva],
        currency: "COP",
        orderId: params[:orderNumber],
        installments: params[:installments],
        description: params[:description],
        creditCard: params[:cardId]
      )
      charge = Tpaga::ChargeApi.add_credit_card_charge(charge_local)
      p charge
      charge.to_hash
    end
  end
end
