class VotesController < ApplicationController

  def create
    @voteable = find_voteable
    @vote = @voteable.votes.build
    @vote.user = current_user
    if @vote.save
      # @vote_count = @voteable.votes.count
      # render json: @vote, status: :ok
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vote = Vote.find(params["id"])
    @voteable = @vote.voteable
    redirect_to root_path unless @vote.user_id == current_user.id
    @vote.destroy
    # render json: @voteable, status: :ok
  end

  private

  def find_voteable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end