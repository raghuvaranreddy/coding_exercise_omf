class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :loan_id, :amount, :payment_date, presence: true
  validate :validate_payment

  def as_json(options=nil)
    {
      id: id,
      amount: amount,
      payment_date: payment_date.strftime("%Y-%m-%d")
    }
  end

  def validate_payment
    return false unless loan_id
    valid = true
    if payment_date && payment_date > Time.now
      errors.add(:payment_date, "Payment date cant be in future")
      valid = false
    end
    loan = Loan.where(id: loan_id).first
    if loan && amount
      loan_outstanding_amount = loan.outstanding_amount
      if loan_outstanding_amount < amount
        errors.add(:amount, "amount should be less than or equal to loan outstanding amount #{loan_outstanding_amount}")
        valid = false
      end
    else
      errors.add(:loan_id, "Invalid Loan Id")
      valid = false
    end
    true
  end
end
