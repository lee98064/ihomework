module ApplicationHelper

	def uimg(img)
		if img.nil? or img == ""
			image_path("student.png")
		else
			img
		end
	end

	def is_finish_weeknote?(weeknotesubject)
		unless weeknotesubject.weeknotes
			'<span style="float:right;color: #28a745"><i class="fas fa-check"></i></span>'.html_safe
		else
			'<span style="float:right;color: #dc3545"><i class="fas fa-times"></i></span>'.html_safe
		end
	end
end
