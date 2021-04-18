class Loan < ActiveRecord::Base
  has_many :payments

  def as_json(options=nil)
    {
      id: id,
      funded_amount: funded_amount,
      outstanding_amount: outstanding_amount
    }
  end

  def outstanding_amount
    funded_amount - payments.pluck(:amount).sum
  end
end
