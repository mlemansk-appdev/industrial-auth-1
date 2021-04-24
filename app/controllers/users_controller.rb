class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :ensure_current_user_owns_page, only: %i[ feed discover]

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def ensure_current_user_owns_page
      if current_user.id != @user.id
        redirect_back fallback_location: root_url, alert: "That's not your feed!"
      end
    end
end