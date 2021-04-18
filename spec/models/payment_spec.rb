require 'rails_helper'

RSpec.describe Payment, type: :model do
  
  describe "#associations" do
    it { expect(Payment.reflect_on_association(:loan).macro).to eq(:belongs_to) }
  end

  describe "#validations" do
    let(:loan) { Loan.create!(funded_amount: 1000.0) }
    let(:payment){ Payment.new(amount: payment_amount, loan_id: loan_id, payment_date: payment_date) }
    let(:payment_amount) { 100 }
    let(:loan_id) { loan.id }
    let(:payment_date) { Date.parse('2021-01-01') }
    
    context 'when payment amount is nil' do
      let(:payment_amount) { nil }
      it { expect(payment.valid?).to be_falsy }
    end
    context 'when payment amount not valid' do
      let(:payment_amount) { 1001 }
      it { expect(payment.valid?).to be_falsy }
    end
    context 'when payment date not valid' do
      let(:payment_date) { nil }
      it { expect(payment.valid?).to be_falsy }
    end
    context 'when loan id is nil' do
      let(:loan_id) { nil }
      it { expect(payment.valid?).to be_falsy }
    end
    context 'when payment date not valid' do
      let(:payment_date) { Date.parse('2022-01-01') }
      it { expect(payment.valid?).to be_falsy }
    end
    context 'when loan id not valid' do
      let(:loan_id) { 10000 }
      it { expect(payment.valid?).to be_falsy }
    end
    context 'when payment valid' do
      it { expect(payment.valid?).to be_truthy }
    end
  end

end
