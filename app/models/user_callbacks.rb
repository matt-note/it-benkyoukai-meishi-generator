class UserCallbacks
  def before_create(user)
    require_github_login(user)
    require_twitter_account(user)
  end

  def after_create(user)
    get_avatar(user)
    get_github_qrcode(user)
    get_twitter_qrcode(user)
  end

  private
    def require_github_login(user)
      begin
        open("https://github.com/#{user.login}")
      rescue OpenURI::HTTPError => e
        user.errors.add(:login, "を見つけらませんでした。")
        puts e.message
      end
    end

    def require_twitter_account(user)
      begin
        open("https://twitter.com/#{user.twitter_account}")
      rescue OpenURI::HTTPError => e
        user.errors.add(:twitter_account, "を見つけらませんでした。")
        puts e.message
      end
    end

    def get_avatar(user)
      processed = ImageProcessing::MiniMagick
        .source("https://github.com/#{user.login}.png")
        .density(350)
        .resize_to_limit(460, 460)
        .call

      user.avatar.attach(io: processed, filename: "avatar")
    end

    def get_github_qrcode(user)
      # テスト用
      url = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://github.com/#{user.login}"

      # url = "https://us-central1-qrcode-with-logo.cloudfunctions.net/qrcode-with-logo/qr/github?t=https://github.com/#{user.login}"
      processed = ImageProcessing::MiniMagick
        .source(url)
        .density(350)
        .resize_to_limit(95, 95)
        .call

      user.github_qrcode.attach(io: processed, filename: "github-qrcode")
    end

    def get_twitter_qrcode(user)
      # テスト用
      url = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://twitter.com/#{user.twitter_account}"

      # url = "https://us-central1-qrcode-with-logo.cloudfunctions.net/qrcode-with-logo/qr/twitter?t=https://twitter.com/#{user.twitter_account}"
      processed = ImageProcessing::MiniMagick
        .source(url)
        .density(350)
        .resize_to_limit(95, 95)
        .call

      user.twitter_qrcode.attach(io: processed, filename: "twitter-qrcode")
    end

    # def get_grass(user)
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
