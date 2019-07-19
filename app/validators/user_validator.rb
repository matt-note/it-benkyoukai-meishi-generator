class UserValidator < ActiveModel::Validator
  def validate(user)
    require_github_login(user)
    require_twitter_account(user)
  end

  private
    def require_github_login(user)
      begin
        open("https://github.com/#{user.login}")
      rescue OpenURI::HTTPError
        user.errors.add(:login, "を見つけられませんでした。")
      end
    end

    def require_twitter_account(user)
      begin
        open("https://twitter.com/#{user.twitter_account}")
      rescue OpenURI::HTTPError
        user.errors.add(:twitter_account, "を見つけられませんでした。")
      end
    end
end
