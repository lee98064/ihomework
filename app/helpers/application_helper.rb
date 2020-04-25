module ApplicationHelper

	def uimg(img)
		p img
		if img.nil? or img == ""
			image_path("student.png")
		else
			img
		end
	end
end
