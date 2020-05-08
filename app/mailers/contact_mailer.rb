class ContactMailer < ApplicationMailer
	def new_post(user)
		@user = user
		mail to: user.email, subject: "您的教室有新貼文!"
	end
end
