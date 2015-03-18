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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
