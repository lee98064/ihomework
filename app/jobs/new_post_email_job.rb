class NewPostEmailJob < ApplicationJob
  queue_as :default

  def perform(classroom,post)
  	users = User.with_any_role({ :name => :student, :resource => classroom }, { :name => :admin, :resource => classroom }, { :name => :teacher, :resource => classroom })
  	users.each do |user|
  		ContactMailer.new_post(user).deliver_now
	end
  end
end
