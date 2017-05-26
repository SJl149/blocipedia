class CollaborationsController < ApplicationController

  def create
    user = User.find(params[:id])
    collaboration = wiki.collaborations.build(user: user)

    if collaboration.save
      flash[:notice] = "Collaboration saved."
    else
      flash[:alert] = "Collaboration failed."
    end
  end

  def destroy

  end
end
