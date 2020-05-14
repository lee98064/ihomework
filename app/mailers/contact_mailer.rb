class ContactMailer < ApplicationMailer
	def new_post(user,post,classroom)
		@user = user
		@post = post
		@classroom = classroom
		make_bootstrap_mail(
			to: user.email,
			from: "線上聯絡簿 <ihomework@ihomework.ga>",
			subject: "#{post.user.try(:uname)} 在 #{classroom.name}中發布了新公告!"
		)
	end
end
