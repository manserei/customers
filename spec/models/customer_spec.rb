require 'spec_helper'

describe Customer do
  before do
    @customer = Customer.new(:first_name => "Hans Hendrik", :last_name => "Mans",
      :email => "hans@mans.de")
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
