module ApplicationHelper

	def uimg(img)
		if img.nil? or img == ""
			image_path("student.png")
		else
			img
		end
	end

	def is_finish_weeknote?(weeknotesubject)
		result = -1
		weeknotesubject.weeknotes.each do |weeknote|
			result = weeknote.user_id if weeknote.user_id == current_user.id
		end
		if result == current_user.id
			'<span style="float:right;color: #28a745"><i class="fas fa-check"></i></span>'.html_safe
		else
			'<span style="float:right;color: #dc3545"><i class="fas fa-times"></i></span>'.html_safe
		end
	end

	def is_have_score?(weeknotesubject)
		result = -1
		weeknotesubject.weeknotes.each do |weeknote|
			result = weeknote.user_id if weeknote.user_id == current_user.id && weeknote.score?
			weeknoteid = weeknote.id
		end
		if result == current_user.id
			link_to '看評分', score_classroom_weeknote_path(@classroom,weeknotesubject), class: "btn btn-secondary btn-sm",remote: true
		end
	end

	def votetotal(items)
		count = 0
		items.each do |item|
			count += item.vote_logs.size
		end
		count
	end

	def vote_range(item,total)
		if item.vote_logs.size == 0
			item.vote_logs.size
		else
			(item.vote_logs.size.to_f / total.to_f) * 100
		end
		
	end
end
