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
      download_path = Rails.root.join("tmp/#{user.login}.jpg").to_s
      url = "https://github.com/#{user.login}.png?size=210"

      Down.download(url, destination: download_path)
      ImageProcessing::MiniMagick
        .source(File.open(download_path))
        .density(350)
        .call(destination: download_path)
    end

    def fetch_github_qrcode(user)
      download_path = Rails.root.join("tmp/#{user.login}-github-qrcode.png").to_s
      url = "https://us-central1-qrcode-with-logo.cloudfunctions.net/qrcode-with-logo/qr/github?t=https://github.com/#{user.login}"

      Down.download(url, destination: download_path)
      ImageProcessing::MiniMagick
        .source(File.open(download_path))
        .density(350)
        .call(destination: download_path)
    end

    def fetch_twitter_qrcode(user)
      download_path = Rails.root.join("tmp/#{user.login}-twitter-qrcode.png").to_s
      url = "https://us-central1-qrcode-with-logo.cloudfunctions.net/qrcode-with-logo/qr/twitter?t=https://twitter.com/#{user.twitter_account}"

      Down.download(url, destination: download_path)
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
        errrors.add(:base, "申し訳ありません。GitHubにアクセスできませんでした。")
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

    # def fetch_grass(user)
    #   size = "119x107"
    #   left_top = "+685+16"
    #
    #   ImageProcessing::MiniMagick
    #     .source("https://grass-graph.moshimo.works/images/#{user.login}.png")
    #     .crop("#{size}#{left_top}")
    #     .density(350)
    #     .call
    # end
end
