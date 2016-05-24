class VotesController < ApplicationController

  def create
    @voteable = find_commentable
    @vote = @voteable.votes.build
    @vote.user = current_user
    # respond_to do |format|
      if @vote.save
        @vote_count = @voteable.votes.count
        # format.html { redirect_to @vote_count, notice: 'Comment Posted.' }
        # format.js
        # format.json { render json: @vote_count, status: :ok }
        render json: @vote_count, status: :ok
      else
        # format.json { render json: @vote_count.errors, status: :unprocessable_entity }
        render json: @vote.errors, status: :unprocessable_entity
      end
    # end
  end

  def destroy
    @vote = Vote.find(params["id"])
    redirect_to root_path unless @vote.user_id == current_user.id
    @voteable = find_commentable
    @vote_count = @voteable.votes.count
    @vote.destroy
    render json: @vote_count, status: :ok
  end

  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end