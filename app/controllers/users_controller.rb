class UsersController < ApplicationController
  def index
    redirect_to root_url
  end

  def show
    @user = User.find_by(public_uid: params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        send_data(MeishiPDF.new(@user).render,
                  filename: "meishi.pdf",
                  type: "application/pdf")

        # send_data(File.read(@user.printable_pdf_path),
        #           filename: "meishi.pdf",
        #           type: "application/pdf")

        File.delete(@user.avatar_path)
        File.delete(@user.github_qrcode_path)
        File.delete(@user.twitter_qrcode_path)
        # File.delete(@user.preview_pdf_path)
        # File.delete(@user.printable_pdf_path)
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
        format.html { redirect_to @user, notice: "名刺原稿を作成できました。" }
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
