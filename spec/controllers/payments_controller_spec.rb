require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) { Loan.create!(funded_amount: 1000.0) }
  
  describe '#create' do
    let(:params) { {payment: { amount: payment_amount, loan_id: loan_id, payment_date: payment_date }} }

    context 'if the payment created successfully' do
      let(:payment_amount) { 10 }
      let(:loan_id) { loan.id }
      let(:payment_date) { Date.parse('2021-01-01') }
      it 'responds with a 201' do
        post :create, params: params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'if the payment is not valid' do
      let(:payment_amount) { 10000 }
      let(:loan_id) { loan.id }
      let(:payment_date) { Date.parse('2021-01-01') }
      it 'responds with a 201' do
        post :create, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

  describe '#show' do
    let(:payment) { Payment.create!(loan_id: loan.id, amount: 100.0, payment_date: Date.parse('2021-01-01')) }

    it 'responds with a 200' do
      get :show, params: { id: payment.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
