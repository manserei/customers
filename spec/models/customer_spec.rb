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
    before do
      subject.save!
    end

    it "should return a sluggified version of the first name" do
      subject.to_param.should == "#{subject.id}-#{subject.first_name.parameterize}"
    end
  end

  context "validating" do

    context "with an unfeasibly short first name" do
      before do
        subject.first_name = "Mo"
      end

      it "should not be valid" do
        subject.should_not be_valid
      end
    end

    context "with the last_name missing" do
      before do
        subject.last_name = ""
      end

      it "should not be valid" do
        subject.should_not be_valid
      end
    end


    context "email" do
      context "with an invalid email" do
        before do
          subject.email = "fake_email"
        end

        it "should not be valid" do
          subject.should_not be_valid
        end
      end

      context "defunct email domains" do

        before do
          subject.email = "reallynoinfo@aol.com"
        end

        it "should not be valid" do
          subject.should_not be_valid
        end

      end

      context "unique email address" do

        before do
          customer = FactoryGirl.create(:customer)

          # Customer.create(
          #   :first_name => "Jeff",
          #   :last_name  => "Winters",
          #   :email      => "jeff@winters.com")
          subject.email = customer.email
        end

        it "should not be valid" do
          subject.should_not be_valid
        end

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

      it "shouldn't add more than the maximum" do
          subject.should_not be_valid
      end

    end
  end

  describe "destroy" do
    before do
      subject.save!
    end

    it { expect { subject.destroy }.to change(Customer, :count).by(-1) }
  end


end
