class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        meishi = MeishiPDF.new(@user)
        send_data meishi.render,
                  filename: "meishi.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: '名刺デザインを作成できました。' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
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
