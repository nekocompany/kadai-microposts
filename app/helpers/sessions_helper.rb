module SessionsHelper
  def current_user
    # find_by(id: id) と find(id)の違い
    # find(id)だとfind(nil)になり
    # Couldn't find User with 'id'={:id=>nil}になる
    @current_user ||= User.find_by(id: session[:user_id])
    
    # a が偽か未定義ならば1を代入。初期化時のイディオムの一種。
    # a ||= 1
    
    # if @current_user
    #   return @current_user
    # else
    #   @current_user = User.find_by(id: session[:user_id])
    #   return @current_user
    # end
    
  end

  def logged_in?
    !!current_user
    # 変数の値がnilだった場合、
    # 「そのままnilを返却するのではなく、
    # falseに置き換えてから返却したい」ときに!!を利用する
    
    #ログインしていれば true
    #ログインしていなければ false を返します。
    
    # if current_user
    #   return true
    # else
    #   return false
    # end
    
  end
end