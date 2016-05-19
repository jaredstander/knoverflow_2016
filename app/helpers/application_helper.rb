module ApplicationHelper

  def is_logged_in
    if(session[:user_id])
      true
    else
      false
    end
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def has_voted_on(item)
    @result = item.votes.where(user_id: current_user.id)
    if(@result.any?)
      true
    else
      false
    end
  end

  def get_vote(item)
    @result = item.votes.where(user_id: current_user.id).first
  end
end