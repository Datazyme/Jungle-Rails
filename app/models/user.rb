class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length:{ minimum:5 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    @email_strip = email.strip 
    user = User.find_by_email(@email_strip)
      if user && user.authenticate(password)
        return user
      end
    nil
  end
end
