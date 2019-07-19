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
      processed = ImageProcessing::MiniMagick
        .source("https://github.com/#{user.login}.png")
        .density(350)
        .call

      user.avatar.attach(io: processed, filename: "avatar")
    end

    def fetch_github_qrcode(user)
      url = "https://us-central1-qrcode-with-logo.cloudfunctions.net/qrcode-with-logo/qr/github?t=https://github.com/#{user.login}"
      processed = ImageProcessing::MiniMagick
        .source(url)
        .density(350)
        .call

      user.github_qrcode.attach(io: processed, filename: "github-qrcode")
    end

    def fetch_twitter_qrcode(user)
      url = "https://us-central1-qrcode-with-logo.cloudfunctions.net/qrcode-with-logo/qr/twitter?t=https://twitter.com/#{user.twitter_account}"
      processed = ImageProcessing::MiniMagick
        .source(url)
        .density(350)
        .call

      user.twitter_qrcode.attach(io: processed, filename: "twitter-qrcode")
    end

    def fetch_github_name(user)
      begin
        url = open("https://api.github.com/users/#{user.login}").read
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
    #   processed = ImageProcessing::MiniMagick
    #     .source("https://grass-graph.moshimo.works/images/#{user.login}.png")
    #     .crop("#{size}#{left_top}")
    #     .density(350)
    #     .call
    #
    #   user.grass.attach(io: processed, filename: "grass")
    # end
end
