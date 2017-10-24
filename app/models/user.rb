class User < ActiveRecord::Base
  has_many :sold_shoes, foreign_key: "seller_id", class_name: "Shoe"
  has_many :bought_shoes, foreign_key: "buyer_id", class_name: "Shoe"
	
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name,:last_name, presence:true, length:{minimum:2}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length:{minimum:8}, on: :create

  has_secure_password

  before_save :email_lowercase
  
  def email_lowercase
    email.downcase!
  end

end
