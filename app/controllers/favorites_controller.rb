class FavoritesController < ApplicationController
  
  before_action :require_user_logged_in
  
  
  def index
    @favd_favorites = current_user.favs.page(params[:page])
    # @users = User.all.page(params[:page])
    # @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
    
  end
  
  
  def create
    
    # フォームから渡されたポストのid fav_idを変数micropostに代入
    micropost = Micropost.find(params[:fav_id])
    current_user.fav(micropost)
    flash[:success] = 'ポストをお気に入りに入れました。'
    
    # フォローの場合はユーザーページオンリーなのでこれでよいが、 
    #redirect_to user
    
    # ファボの場合はindexとuser/idの場合がある
    # ページ遷移無しの表示更新は習ってない
    # 状況に応じてリダイレクト先を変化させるか？
    
    # if userページ
    # rediret_to userページ
    # else 
    # redirect_to root_url
    
    # どうやってindexとuser/idを判定するか
    
    
    
    redirect_to request.referrer || root_url
    
    # unless params[:favd_id].blank?
      
    #   redirect_to controller: :users, action: :show, id: params[:favd_id]
      
    # else
      
    #   redirect_to root_url
    # end
    
    
    
  end

    
  def destroy
    micropost = Micropost.find(params[:fav_id])
    current_user.unfav(micropost)
    flash[:success] = 'ポストをお気に入りからはずしました。'
    
    
  
    #redirect_to root_url
    
    # unless params[:favd_id].blank?
      
    #   redirect_to controller: :users, action: :show, id: params[:favd_id]
      
    # else
      
    #   redirect_to root_url
    # end
    
    redirect_to request.referrer || root_url
    
  end
end
