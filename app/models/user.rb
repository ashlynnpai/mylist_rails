class User < ActiveRecord::Base
  
  has_secure_password validations: false
  
  has_many :railscasts
  has_many :casts, through: :railscasts
  has_many :notes
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 7}
  validates :name, presence: true,  uniqueness: { case_sensitive: false }
  validates_presence_of :password_confirmation, :if => :password_present?
  validates_confirmation_of :password, :if => :password_present?
  
  def password_present?
    !password.nil?
  end
  
end