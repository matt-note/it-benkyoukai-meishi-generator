class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    redirect_to root_url
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        meishi = MeishiPDF.new(@user)
        send_data meishi.render,
                  filename: "meishi.pdf",
                  type: "application/pdf"
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: '名刺原稿を作成できました。' }
      else
        format.html { render :new }
      end
    end
  end

  private
    def set_user
      @user = User.friendly.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :login,
        :twitter_account,
        :avatar,
        :github_qrcode,
        :twitter_qrcode
      )
    end
end
