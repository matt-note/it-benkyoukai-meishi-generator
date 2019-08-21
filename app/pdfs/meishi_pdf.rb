class MeishiPDF < Prawn::Document
  def initialize(user)
    super(
      page_size: [445, 343],
      margin: [0,0,0,0]
    )

    # 表面
    stroke_tonbo
    draw_github_logo
    draw_twitter_logo
    draw_avatar(user)
    draw_name(user)
    draw_job(user)
    draw_login(user)
    draw_twitter_account(user)
    draw_twitter_account(user)

    start_new_page

    # 裏面
    stroke_tonbo
    draw_github_qrcode(user)
    draw_twitter_qrcode(user)
  end

  private
    def stroke_tonbo
      # 左上
      stroke_color "808080"
      stroke { line [0, 248], [85, 248] }
      stroke { line [0, 258], [95, 258] }
      stroke { line [85, 343], [85, 248] }
      stroke { line [95, 343], [95, 258] }

      # 右上
      stroke { line [350, 343], [350, 258] }
      stroke { line [360, 343], [360, 248] }
      stroke { line [445, 248], [360, 248] }
      stroke { line [445, 258], [350, 258] }

      # 左下
      stroke { line [85, 0], [85, 95] }
      stroke { line [95, 0], [95, 85] }
      stroke { line [0, 85], [95, 85] }
      stroke { line [0, 95], [85, 95] }

      # 右下
      stroke { line [350, 0], [350, 85] }
      stroke { line [360, 0], [360, 95] }
      stroke { line [445, 85], [350, 85] }
      stroke { line [445, 95], [360, 95] }
    end

    def draw_github_logo
      image(Rails.root.join("app/assets/images/github.png"), width: 14, height: 14, at: [222, 160])
    end

    def draw_twitter_logo
      image(Rails.root.join("app/assets/images/twitter.png"), width: 15, height: 15, at: [222, 142])
    end

    def draw_avatar(user)
      image(user.avatar_path, width: 70, height: 70, at: [124, 220])
    end

    def draw_name(user)
      font(Rails.root.join("app/assets/fonts/Roboto-Regular.ttf"), size: 10) do
        draw_text("#{user.name}", at: [220, 212])
      end
    end

    def draw_job(user)
      font(Rails.root.join("app/assets/fonts/Roboto-Light.ttf"), size: 9) do
        draw_text("Programmer", at: [220, 200])
      end
    end

    def draw_login(user)
      font(Rails.root.join("app/assets/fonts/Roboto-Light.ttf"), size: 10) do
        draw_text("#{user.login}", at: [241, 149])
      end
    end

    def draw_twitter_account(user)
      font(Rails.root.join("app/assets/fonts/Roboto-Light.ttf"), size: 10) do
        draw_text("#{user.twitter_account}", at: [241, 131])
      end
    end

    def draw_github_qrcode(user)
      image(user.github_qrcode_path, width: 80, height: 80, at: [124, 211])
    end

    def draw_twitter_qrcode(user)
      image(user.twitter_qrcode_path, width: 80, height: 80, at: [240, 211])
    end
end
