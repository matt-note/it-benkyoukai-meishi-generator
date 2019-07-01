class UserCallbacks
  def after_create(user)
    get_avatar(user)
    get_qrcode(user)
    get_grass(user)
  end

  private
    # begin-resuce 処理を後で書く。
    def get_avatar(user)
      processed = ImageProcessing::MiniMagick
        .source("https://github.com/#{user.name}.png")
        .density(350)
        .resize_to_limit(460, 460)
        .call

      user.avatar.attach(io: processed, filename: "avatar")
    end

    def get_qrcode(user)
      processed = ImageProcessing::MiniMagick
        .source("https://api.qrserver.com/v1/create-qr-code/?size=460x460&data=https://github.com/#{user.name}")
        .density(350)
        .resize_to_limit(50, 50)
        .call

      user.qrcode.attach(io: processed, filename: "qrcode")
    end

    def get_grass(user)
      size = "119x107"
      left_top = "+685+16"

      processed = ImageProcessing::MiniMagick
        .source("https://grass-graph.moshimo.works/images/#{user.name}.png")
        .crop("#{size}#{left_top}")
        .density(350)
        .call

      user.grass.attach(io: processed, filename: "grass")
    end
end
