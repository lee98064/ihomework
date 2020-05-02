class User < ApplicationRecord
  rolify
  # after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  
  has_many :classrooms, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :testlists, dependent: :destroy
  
  def name
		self.uname
	end

	# def assign_default_role
	#    self.add_role(:user) if self.roles.blank?
	# end

  def remember_me
    true
  end
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:google_token => access_token.credentials.token, :google_uid => access_token.uid ).first    
    if user
      remember_me(user)
      return user
    else
      existing_user = User.where(:email => data["email"]).first
      if  existing_user
        existing_user.google_uid = access_token.uid
        existing_user.google_token = access_token.credentials.token
        existing_user.uimg = data["image"]
        existing_user.save!
        return existing_user
      else
    # Uncomment the section below if you want users to be created if they don't exist
        user = User.create(
            uname: data["name"],
            uimg: data["image"],
            email: data["email"],
            password: Devise.friendly_token[0,20],
            google_token: access_token.credentials.token,
            google_uid: access_token.uid
          )
      end
    end
  end
end
