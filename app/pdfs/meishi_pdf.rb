class MeishiPDF < Prawn::Document
  def initialize(user)
    super(
      page_size: [445, 343],
      margin: [0,0,0,0]
    )

    # 表面
    draw_tonbo
    draw_github_logo
    draw_avatar(user)
    draw_name(user)
    draw_login(user)
    
    start_new_page

    # 裏面
    draw_tonbo
    draw_qrcode(user)
    draw_grass(user)
  end

  private
    def draw_tonbo
      image Rails.root.join("app/assets/images/tonbo.jpg")
    end

    def draw_github_logo
      image Rails.root.join("app/assets/images/github.png"), width: 18, height: 18, at: [212, 170]
    end

    def draw_avatar(user)
      avatar_path = ActiveStorage::Blob.service.path_for(user.avatar.key)
      image(avatar_path, width: 80, height: 80, at: [115, 215])
    end

    def draw_name(user)
      font(Rails.root.join("app/assets/fonts/Roboto-Light.ttf"), size: 23) do
        draw_text "#{user.name}", at: [210, 186]
      end
    end

    def draw_login(user)
      font(Rails.root.join("app/assets/fonts/Roboto-Thin.ttf"), size: 18) do
        draw_text "#{user.login}", at: [235, 155]
      end
    end

    def draw_qrcode(user)
      qrcode_path = ActiveStorage::Blob.service.path_for(user.qrcode.key)
      image(qrcode_path, width: 70, height: 70, at: [115, 205])
    end

    def draw_grass(user)
      grass_path = ActiveStorage::Blob.service.path_for(user.grass.key)
      image(grass_path, at: [205, 225])
    end
end
