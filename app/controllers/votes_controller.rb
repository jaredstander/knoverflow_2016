class VotesController < ApplicationController

  def create
    @voteable = find_voteable
    @vote = @voteable.votes.build
    @vote.user = current_user
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote Saved.' }
        format.js
        format.json { render json: @vote, status: :created, location: @vote }
      else
        render json: @vote.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @vote = Vote.find(params["id"])
    @voteable = @vote.voteable
    redirect_to root_path unless @vote.user_id == current_user.id
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to @voteable, notice: 'Vote Saved.' }
      format.js
      format.json { render json: @voteable, status: :created, location: @voteable }
    end
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