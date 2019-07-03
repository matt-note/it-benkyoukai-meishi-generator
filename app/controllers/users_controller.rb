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
    return_value = confirm_user(@user)

    if return_value.nil?
      redirect_to new_user_url, notice: "GitHubログイン名を見つけられませんでした。"
    else
      json = JSON.parse(return_value)
      set_name(@user, json)

      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: '名刺デザインを作成できました。' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.friendly.find(params[:id])
    end

    def confirm_user(user)
      begin
        open("https://api.github.com/users/#{user.login}").read
      rescue OpenURI::HTTPError => error
        puts error.message
        return nil
      end
    end

    def set_name(user, json)
      if json["name"].nil?
        user.name = user.login
      else
        user.name = json["name"]
      end
    end

    def user_params
      params.require(:user).permit(:login, :name, :twitter_name, :avatar)
    end
end
