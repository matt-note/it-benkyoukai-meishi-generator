class UsersController < ApplicationController
  def index
    redirect_to root_url
  end

  def show
    @user = User.friendly.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        send_data(MeishiPDF.new(@user).render,
                  filename: "meishi.pdf",
                  type: "application/pdf")

        File.delete(Rails.root.join("tmp/#{@user.login}.jpg").to_s)
        File.delete(Rails.root.join("tmp/#{@user.login}-github-qrcode.png").to_s)
        File.delete(Rails.root.join("tmp/#{@user.login}-twitter-qrcode.png").to_s)
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
    def user_params
      params.require(:user).permit(:login,:twitter_account)
    end
end
