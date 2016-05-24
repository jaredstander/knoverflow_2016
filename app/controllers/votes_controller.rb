class VotesController < ApplicationController
  def create
    @commentable = find_commentable
    @vote = @commentable.votes.build
    @vote.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment Posted.' }
        format.js
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  def destroy
    @vote = Vote.find(params["id"])
    redirect_to root_path unless @vote.user_id == current_user.id
    @comment.destroy
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