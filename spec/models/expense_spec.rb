require 'spec_helper'

describe Expense do

  let(:user) { FactoryGirl.create(:user) }
  before { @expense = user.expenses.build(amount: 23.01) }

  subject { @expense }

  it { should respond_to(:amount) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  
  it { should be_valid }

  describe "when user_id is not present" do
    before { @expense.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank amount" do
    before { @expense.amount = nil }
    it { should_not be_valid }
  end
  
  describe "with non number amount" do
    before { @expense.amount = "Foo" }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Expense.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
end
