require 'spec_helper'

describe "Expense pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "expense creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create an expense" do
        expect { click_button "Post" }.not_to change(Expense, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'expense_amount', with: 23.21 }
      it "should create an expense" do
        expect { click_button "Post" }.to change(Expense, :count).by(1)
      end
    end
  end
  
  describe "expense destruction" do
    before { FactoryGirl.create(:expense, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete an expense" do
        expect { click_link "delete" }.to change(Expense, :count).by(-1)
      end
    end
  end
  
end

