class CollaborationsController < ApplicationController

  def create
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    Collaboration.create(user_id: user.id, wiki_id: wiki.id)

    if Collaboration.create(user_id: user.id, wiki_id: wiki.id)
      flash[:notice] = "Collaboration saved."
    else
      flash[:alert] = "Collaboration failed."
    end
    redirect_to edit_wiki_path(wiki)
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])
    @collaboration = Collaboration.find(user_id: user.id, wiki_id: wiki.id)

    if @collaboration.destroy
      flash[:notice] = "#{user.email} was removed successfully."
    else
      flash.now[:alert] = 'There was a problem removing the user.'
    end
    redirect_to edit_wiki_path(wiki)
  end
end
