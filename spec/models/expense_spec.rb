require 'spec_helper'

describe Expense do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is wrong!
    @expense = Expense.new(amount: 23.10, user_id: user.id)
  end

  subject { @expense }

  it { should respond_to(:amount) }
  it { should respond_to(:user_id) }
end
