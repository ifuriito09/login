class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_user, only: [:create]

  def new
  end

  def create
    if @user&&@user.authenticate(session: params[:session][:password])
      puts 'OK いいね'
      sign_in(@user)
    else
      flash[:danger] = 'パスワードが違います'
      render 'new'
    end
  end


  def createw
    if @user.authenticate("aaa")
      p "hahah"
    end
  end


  def destroy
    sign_out
    redirect_to login_path
  end

  private

    def set_user
      //ばぐってる
      p session_params
      @user = User.find_by!({name: session_params[:name])
    rescue
      flash[:danger] = 'メールアドレスが違います'
      render action: 'new'
    end

    # 許可するパラメータ
    def session_params
      params.require(:session).permit(:name, :password)
    end

end
