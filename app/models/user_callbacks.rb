class UserCallbacks
  def after_create(user)
    get_avatar(user)
    get_qrcode(user)
    get_grass(user)
  end

  private
    def get_avatar(user)
      processed = ImageProcessing::MiniMagick
        .source("https://github.com/#{user.login}.png")
        .density(350)
        .resize_to_limit(460, 460)
        .call

      user.avatar.attach(io: processed, filename: "avatar")
    end

    def get_qrcode(user)
      processed = ImageProcessing::MiniMagick
        .source("https://api.qrserver.com/v1/create-qr-code/?size=460x460&data=https://github.com/#{user.login}")
        .density(350)
        .resize_to_limit(70, 70)
        .call

      user.qrcode.attach(io: processed, filename: "qrcode")
    end

    def get_grass(user)
      size = "119x107"
      left_top = "+685+16"

      processed = ImageProcessing::MiniMagick
        .source("https://grass-graph.moshimo.works/images/#{user.login}.png")
        .crop("#{size}#{left_top}")
        .density(350)
        .call

      user.grass.attach(io: processed, filename: "grass")
    end
end
