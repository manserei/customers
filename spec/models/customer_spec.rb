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
  let(:user)       { FactoryGirl.build(:customer) }
  let(:saved_user) { FactoryGirl.create(:customer) }

  subject { user }

  describe '#full_name' do
    its(:full_name) { should == "#{user.last_name}, #{user.first_name}" }
  end

  describe '#to_param' do
    subject { saved_user }
    its(:to_param) { should == "#{saved_user.id}-#{saved_user.first_name.parameterize}" }
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
  end

  describe "destroy" do
    subject { user }

    it do
      subject.save!
      expect { subject.destroy }.to change(Customer, :count).by(-1)
    end
  end

  it "should not be allowed to have more than 10 projects"

  describe '#reached_project_limit?' do
    context "when customer has less than 10 projects" do
      it "should be true"
    end

    context "when customer has 10 or more projects" do
      it "should be false"
    end
  end
end
