class MeishiPDF < Prawn::Document
  def initialize(user)
    super(
      page_size: [445, 343],
      margin: [0,0,0,0]
    )

    draw_tonbo
    image Rails.root.join("app/assets/images/github.png"), width: 18, height: 18, at: [212, 170]

    draw_avatar(user)

    font(Rails.root.join("app/assets/fonts/Roboto-Light.ttf"), size: 23) do
      draw_text "matsumoto", at: [210, 186]
    end

    font(Rails.root.join("app/assets/fonts/Roboto-Thin.ttf"), size: 18) do
      draw_text "matt-note", at: [235, 155]
    end

    # 裏面
    start_new_page

    draw_tonbo
    draw_qrcode(user)
    draw_grass(user)
  end

  def draw_tonbo
    image Rails.root.join("app/assets/images/tonbo.jpg")
  end

  def draw_avatar(user)
    avatar_path = ActiveStorage::Blob.service.path_for(user.avatar.key)
    image(avatar_path, width: 80, height: 80, at: [115, 215])
  end

  def draw_qrcode(user)
    qrcode_path = ActiveStorage::Blob.service.path_for(user.qrcode.key)
    image(qrcode_path, width: 60, height: 60, at: [115, 205])
  end

  def draw_grass(user)
    grass_path = ActiveStorage::Blob.service.path_for(user.grass.key)
    image(grass_path, at: [195, 225])
  end
end
