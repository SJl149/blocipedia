class WikiPolicy < ApplicationPolicy
  
  def update?
    user.present? && (user.admin? || record.user == user || record.collaborating_users.include?(user))
  end

  def destroy?
    user.present? && (user.admin? || record.user == user)
  end
  
  def collaborators?
    user.present? && (user.admin? || record.user == user)
  end
  
  class Scope
    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private == false || wiki.user == user || wiki.collaborating_users.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private == false || wiki.collaborating_users.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end