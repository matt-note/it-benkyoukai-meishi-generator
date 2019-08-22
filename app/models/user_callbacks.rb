class UserCallbacks
  def after_create(user)
    fetch_images(user)
    fetch_github_name(user)
  end

  private
    def fetch_images(user)
      fetch_avatar(user)
      fetch_github_qrcode(user)
      fetch_twitter_qrcode(user)
    end

    def fetch_avatar(user)
      download_path = user.avatar_path
      url = "https://github.com/#{user.login}.png"

      begin
        Down.download(url, destination: download_path)
      rescue
        user.errors.add(:base, "申し訳ありません。画像を取得できませんでした。")
      end
      convert_image(download_path)
    end

    def fetch_github_qrcode(user)
      download_path = user.github_qrcode_path
      url = "https://us-central1-qrcode-with-logo.cloudfunctions.net/qrcode-with-logo/qr/github?t=https://github.com/#{user.login}"

      begin
        Down.download(url, destination: download_path)
      rescue
        user.errors.add(:base, "申し訳ありません。画像を取得できませんでした。")
      end
      convert_image(download_path)
    end

    def fetch_twitter_qrcode(user)
      download_path = user.twitter_qrcode_path
      url = "https://us-central1-qrcode-with-logo.cloudfunctions.net/qrcode-with-logo/qr/twitter?t=https://twitter.com/#{user.twitter_account}"

      begin
        Down.download(url, destination: download_path)
      rescue
        user.errors.add(:base, "申し訳ありません。画像を取得できませんでした。")
      end
      convert_image(download_path)
    end

    def convert_image(download_path)
      ImageProcessing::MiniMagick
        .source(File.open(download_path))
        .density(350)
        .call(destination: download_path)
    end

    def fetch_github_name(user)
      begin
        url = open("https://api.github.com/users/#{user.login}",
                   "Authorization" => "token #{ENV['GITHUB_ACCESS_TOKEN']}").read
      rescue OpenURI::HTTPError
        user.errors.add(:base, "申し訳ありません。GitHubにアクセスできませんでした。")
        url = nil
      end

      if url
        json = JSON.parse(url)
        set_name(user, json)
      end
    end

    def set_name(user, json)
      if json["name"].nil?
        user.name = user.login
      else
        user.name = json["name"]
      end
      user.update(name: user.name)
    end
end
