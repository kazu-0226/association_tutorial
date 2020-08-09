class RelationshipsController < ApplicationController
  def create
    follow = current_user.followings.build(follower_id: params[:user_id])
    follow.save
    redirect_to request.referer
  end

  def destroy
    follow = current_user.followings.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to request.referer
  end

end
