class PagesController < ApplicationController
  def index
    if get_user
      if @user.oauth_token.blank? && session['oauth_token'].blank?
        redirect_to destroy_user_session_path
      else
        if @user.oauth_token.blank?
          @user.update(
            oauth_token: session['oauth_token'],
            oauth_secret: session['oauth_secret']
          )
        end
        @categories = Category.where(user_id: @user)
        @words = Word.where(user_id: @user)
        render 'pages/user_index'
      end
    end
  end

  def mypage
    @this_user = User.find_by_user_name(params[:user_name])
    redirect_to root_path if @this_user.blank?

    get_user
    get_categories @this_user
    get_words @this_user
    @words.reverse_order!
  end
end
