require 'spec_helper'

# EXERCISES:
#
# - Test that a customer needs to have first name,
#   last name and email to be valid.
# - Test that a customer's email address needs to be unique.
# - Test if destroying a customer record changes the number
#   of customers in the database.
# - Test that a customer is not allowed to have an aol.com email address.
# - Test that a customer can't have more than 10 projects.


describe Customer do
  before do
    @customer = Customer.new(
      :first_name => "Hans Hendrik",
      :last_name  => "Mans",
      :email      => "hans@mans.de")
  end

  describe '#full_name' do
    it "should return the full name" do
      @customer.full_name.should == "Mans, Hans Hendrik"
    end
  end

  describe '#to_param' do
    before do
      @customer.save
    end

    it "should return a sluggified version of the first name" do
      @customer.to_param.should == "#{@customer.id}-hans-hendrik"
    end
  end

  context "with the last_name missing" do
    before do
      @customer.last_name = ""
    end

    it "should not be valid" do
      @customer.should_not be_valid
    end
  end
end
