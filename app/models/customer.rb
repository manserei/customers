class Customer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :birthday

  validates_presence_of :last_name, :email
  validates_uniqueness_of :email
  validates_length_of :first_name, :last_name, :within => 3..50, :allow_blank => true
  validates_format_of :email, :with => /^.+@.+\..+$/, :message => "doesn't look like an email address"

  validate do
    if email =~ /aol\.com$/
      errors.add(:email, "we don't want customers from AOL")
    end
  end

  has_many :notes
  has_many :projects

  scope :adult, lambda { where(["birthday < ?", 18.years.ago]) }
  scope :from, lambda { |city| where(:city => city) }

  def reached_project_limit?
    projects.count >= 10
  end

  # class << self
  #   def adult
  #     where(["birthday < ?", 18.years.ago])
  #   end

  #   def from(city)
  #     where(:city => city)
  #   end
  # end

  after_create :create_initial_note
  after_update :create_update_note

  def create_initial_note
    notes.create(:text => "Customer has been created.")
  end

  def create_update_note
    notes.create(:text => "Customer has been updated. Changed attributes are:\n\n#{changed_attributes}")
  end

  def full_name
    # last_name + ", " + first_name
    # [last_name, ", ", first_name].join
    # [last_name, first_name].join(", ")
    "#{last_name}, #{first_name}"
  end

  def to_s
    full_name
  end

  def to_param
    "#{id}-#{first_name.parameterize}"
  end

  # attr_accessor :email_confirmation

  # validate :check_email_confirmation

  # def check_email_confirmation
  #   if email != email_confirmation
  #     errors.add(:email_confirmation, "doesn't match your email address")
  #   end
  # end

  # def email_confirmation
  #   @email_confirmation
  # end

  # def email_confirmation=(value)
  #   @email_confirmation = value
  # end
end
