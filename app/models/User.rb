# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_id        :text
#  full_name       :string
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  before_save { self.email_id = email_id.downcase }

  validates :full_name, :presence => true , length: { maximum: 50 }
  validates :full_name, :uniqueness => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email_id, :presence => true , length: { maximum: 255 } , format: { with: VALID_EMAIL_REGEX },  uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 4 }

  has_and_belongs_to_many :recipes
end

