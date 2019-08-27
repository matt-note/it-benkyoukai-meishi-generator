# frozen_string_literal: true

class MeishiPDF < Prawn::Document
  def initialize(user)
    super(
      page_size: [285, 156],
      margin: [0, 0, 0, 0]
    )

    # 表面
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
    draw_github_qrcode(user)
    draw_twitter_qrcode(user)
  end

  private

  def draw_avatar(user)
    image(user.avatar_path, width: 70, height: 70, at: [37, 122])
  end

  def draw_name(user)
    font(Rails.root.join('app/assets/fonts/Roboto-Regular.ttf'), size: 10) do
      draw_text(user.name.to_s, at: [130, 112])
    end
  end

  def draw_job(_user)
    font(Rails.root.join('app/assets/fonts/Roboto-Light.ttf'), size: 9) do
      draw_text('Programmer', at: [130, 100])
    end
  end

  def draw_github_logo
    image(Rails.root.join('app/assets/images/github.png'), width: 13, height: 13, at: [130, 71])
  end

  def draw_twitter_logo
    image(Rails.root.join('app/assets/images/twitter.png'), width: 14, height: 14, at: [130, 53])
  end

  def draw_login(user)
    font(Rails.root.join('app/assets/fonts/Roboto-Light.ttf'), size: 10) do
      draw_text(user.login.to_s, at: [148, 61])
    end
  end

  def draw_twitter_account(user)
    font(Rails.root.join('app/assets/fonts/Roboto-Light.ttf'), size: 10) do
      draw_text(user.twitter_account.to_s, at: [148, 42])
    end
  end

  def draw_github_qrcode(user)
    image(user.github_qrcode_path, width: 80, height: 80, at: [54, 120])
  end

  def draw_twitter_qrcode(user)
    image(user.twitter_qrcode_path, width: 80, height: 80, at: [150, 120])
  end
end
