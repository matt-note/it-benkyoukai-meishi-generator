#	frozen_string_literal:	true

require "rails_helper"

RSpec.describe UsersController, type: :request do
  describe "GET /users#new" do
    example "入力画面にアクセスできること" do
      get new_user_path
      expect(response).to have_http_status :ok
    end
  end

  describe "POST /users" do
    context "パラメータが妥当な場合", vcr: true do
      params = { user: FactoryBot.attributes_for(:user) }

      example "リクエストが成功すること" do
        post users_path, params: params
        expect(response).to have_http_status 302
      end

      example "ユーザーを登録できること" do
        expect {
          post users_path, params: params
        }.to change(User, :count).by(1)
      end
    end

    context "パラメータが不正な場合", vcr: true do
      example "何も入力していない場合はエラーメッセージを表示すること" do
        params = { user: { login: "", twitter_account: "" } }

        post users_path, params: params
        expect(response).to have_http_status :ok
        expect(response.body).to be_include "GitHubアカウントを入力してください。"
        expect(response.body).to be_include "Twitterアカウントを入力してください。"
      end

      example "存在しないアカウントを入力した時にエラーメッセージを表示すること" do
        invalid_name = "erquiopyerioquriopqeupfoiasdkldjfkladngvaldvn"
        params = { user: { login: invalid_name, twitter_account: invalid_name } }

        post users_path, params: params
        expect(response.body).to be_include "GitHubアカウントを見つけられませんでした。"
        expect(response.body).to be_include "Twitterアカウントを見つけられませんでした。"
      end
    end
  end
end
