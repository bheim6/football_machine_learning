class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :token

  def self.from_omniauth(auth_info)
      user = self.find_or_create_by(uid: auth_info.uid)
      user.name           = auth_info.info.name
      user.nickname       = auth_info.info.nickname
      user.token          = auth_info.credentials.token
      user.save
      user
  end
end
