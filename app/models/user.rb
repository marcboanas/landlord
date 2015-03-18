# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  first_name          :string
#  last_name           :string
#  email               :string
#  password_hash       :string
#  password_salt       :string
#  verification_digest :string
#  email_verification  :boolean
#  verified_at         :datetime
#  api_authtoken       :string
#  authtoken_expiry    :datetime
#  provider            :string
#  uid                 :string
#  admin               :boolean
#  remember_digest     :string
#  reset_digest        :string
#  reset_sent_at       :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessor :password, :remember_token, :verification_token, :reset_token
  before_save :encrypt_password, :downcase_email
  before_create :create_verification_digest

  validates_confirmation_of :password
  validates_presence_of :email, on: :create
  validates :password, length: { in: 6..30 }, on: :create
  validates_format_of :email, with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email
  has_many :user_lists

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def verified
    update_attribute(:email_verification, true)
    update_attribute(:verified_at, Time.now)
  end

  def send_verification_email
    UserMailer.account_verification(self).deliver
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def full_name
    @full_name = self.first_name + " " + self.last_name
    return @full_name
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(api, login_name, password)
    user = self.where("email =?", login_name).first

    if user
      if api
        puts "******************* #{password} 1"

        begin
          password = AESCrypt.decrypt(password, ENV["API_AUTH_PASSWORD"])
        rescue Exception => e
          password = nil
          puts "error - #{e.message}"
        end

        puts "******************* #{password} 2"
      end

      if user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
    else
      nil
    end
  end

  def to_json(options = {})
    options[:except] ||= [:id, :password_hash, :password_salt, :email_verification, :verification_code, :created_at, :updated_at]
    super(options)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_verification_digest
    self.verification_token = User.new_token
    self.verification_digest = User.digest(verification_token)
  end
end
