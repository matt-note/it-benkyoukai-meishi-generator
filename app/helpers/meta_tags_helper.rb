# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      site: "IT勉強会用 名刺ジェネレーター",
      reverse: true,
      charset: "utf-8",
      description: "ラクスルにそのまま入稿できる「IT勉強会用の名刺原稿（PDF）」を作成するWebサービスです",
      viewport: "width=device-width, initial-scale=1.0",
      og: {
        title: :title,
        type: "website",
        site_name: :site,
        description: :description,
        image: "https://it-benkyoukai-meishi.herokuapp.com//ogp/ogp.png",
        url: "https://it-benkyoukai-meishi.herokuapp.com/",
      },
      twitter: {
        site: "@matt59649858",
        card: "summary_large_image",
        description: :description,
        image: "https://it-benkyoukai-meishi.herokuapp.com/ogp/ogp.png",
        domain: "https://it-benkyoukai-meishi.herokuapp.com",
      }
    }
  end
end
