require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { Loan.create(funded_amount: 1000) }

  describe "#associations" do
    it { expect(Loan.reflect_on_association(:payments).macro).to eq(:has_many) }
  end

  describe "#outstanding_amount" do
    let(:payment) { Payment.create(amount: 100, loan_id: loan.id, payment_date: Date.parse("2021-01-01")) }
    it 'should return outstanding amount on loan' do
      expect(loan.outstanding_amount).to eq 900
    end
  end

  describe '#as_json' do
    it { expect(loan.as_json(nil)).to have_key(:funded_amount) }
  end

end
