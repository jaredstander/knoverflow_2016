module ApplicationHelper

  def is_logged_in
    session[:user_id] ? true : false
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def has_answered(question)
    @result = question.answers.where(user_id: current_user.id)
    @result.any? ? true : false
  end

  def has_voted_on(item)
    @result = item.votes.where(user_id: current_user.id)
    @result.any? ? true : false
  end

  def get_vote(item)
    @result = item.votes.where(user_id: current_user.id).first
  end
end