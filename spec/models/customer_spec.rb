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
  subject { FactoryGirl.build(:customer) }

  describe '#full_name' do
    it "should return the full name" do
      subject.full_name.should == "#{subject.last_name}, #{subject.first_name}"
    end
  end

  describe '#to_param' do
    before { subject.save! }

    it "should return a sluggified version of the first name" do
      subject.to_param.should == "#{subject.id}-#{subject.first_name.parameterize}"
    end
  end

  context "validating" do
    context "with an unfeasibly short first name" do
      before { subject.first_name = "Mo" }
      it { should_not be_valid }
    end

    context "with the last_name missing" do
      before { subject.last_name = "" }
      it { should_not be_valid }
    end

    context "email" do
      context "with an invalid email" do
        before { subject.email = "fake_email" }
        it { should_not be_valid }
      end

      context "defunct email domains" do
        before { subject.email = "reallynoinfo@aol.com" }
        it { should_not be_valid }
      end

      context "unique email address" do
        before do
          customer = FactoryGirl.create(:customer)
          subject.email = customer.email
        end

        it { should_not be_valid }
      end

    end

    context "maximum projects" do
      before do
        subject.save!
        10.times do |i|
          subject.projects.create({ :title => "Project #{i}" })
        end
        subject.projects.new({ :title => "Project 11" })
      end

      it { should_not be_valid }
    end
  end

  describe "destroy" do
    before do
      subject.save!
    end

    it { expect { subject.destroy }.to change(Customer, :count).by(-1) }
  end


end
