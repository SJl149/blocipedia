class CollaborationsController < ApplicationController

  def create
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    
    if wiki.collaborating_users.include?(user)
      flash[:alert] = "#{user.email} is already a collaborator!"
    else
      Collaboration.create(user_id: user.id, wiki_id: wiki.id)

      if Collaboration.create(user_id: user.id, wiki_id: wiki.id)
        flash[:notice] = "#{user.email} is now a collaborator."
      else
        flash[:alert] = "Collaboration failed."
      end
    end
    redirect_to edit_wiki_path(wiki)
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    

    if wiki.collaborating_users.destroy(user)
      flash[:notice] = "#{user.email} was removed successfully."
    else
      flash.now[:alert] = 'There was a problem removing the user.'
    end
    redirect_to edit_wiki_path(wiki)
  end
end
