class MeishiPDF < Prawn::Document
  def initialize(user)
    super(
      page_size: [445, 343],
      margin: [0,0,0,0]
    )

    # 表面
    draw_tonbo
    draw_github_logo
    draw_twitter_logo
    draw_avatar(user)
    draw_name(user)
    draw_login(user)
    draw_twitter_account(user)
    draw_twitter_account(user)

    start_new_page

    # 裏面
    draw_tonbo
    draw_github_qrcode(user)
    draw_twitter_qrcode(user)
  end

  private
    def draw_tonbo
      image Rails.root.join("app/assets/images/tonbo.jpg")
    end

    def draw_github_logo
      image Rails.root.join("app/assets/images/github.png"), width: 14, height: 14, at: [212, 174]
    end

    def draw_twitter_logo
      image Rails.root.join("app/assets/images/twitter.png"), width: 15, height: 15, at: [212, 152]
    end

    def draw_avatar(user)
      avatar_path = ActiveStorage::Blob.service.path_for(user.avatar.key)
      image(avatar_path, width: 80, height: 80, at: [115, 215])
    end

    def draw_name(user)
      font(Rails.root.join("app/assets/fonts/Roboto-Light.ttf"), set_font_size(user)) do
        draw_text "#{user.name}", at: [210, 190]
      end
    end

    def draw_login(user)
      font(Rails.root.join("app/assets/fonts/Roboto-Thin.ttf"), size: 10) do
        draw_text "#{user.login}", at: [230, 163]
      end
    end

    def draw_twitter_account(user)
      font(Rails.root.join("app/assets/fonts/Roboto-Thin.ttf"), size: 10) do
        draw_text "#{user.twitter_account}", at: [230, 141]
      end
    end

    def draw_github_qrcode(user)
      github_qrcode_path = ActiveStorage::Blob.service.path_for(user.github_qrcode.key)
      image(github_qrcode_path, width: 95, height: 95, at: [110, 220])
    end

    def draw_twitter_qrcode(user)
      twitter_qrcode_path = ActiveStorage::Blob.service.path_for(user.twitter_qrcode.key)
      image(twitter_qrcode_path, width: 95, height: 95, at: [230, 220])
    end

    def set_font_size(user)
      case user.name.size
      when 1..10
        { size: 18 }
      when 11..12
        { size: 17 }
      when 13..14
        { size: 15 }
      when 15..16
        { size: 14 }
      when 17..18
        { size: 13 }
      when 19..20
        { size: 12 }
      when 21..22
        { size: 11 }
      else
        { size: 10 }
      end
    end
end
