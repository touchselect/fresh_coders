# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: 'admin@admin.com', password: 'ffffff')
User.create(email: 'user@user.com', name: 'user', password: 'ffffff')
Category.create(name: "質問と回答")
Category.create(name: "プログラミング言語")
Category.create(name: "フレームワークとライブラリ")
Category.create(name: "ソフトウェア開発ツール")
Category.create(name: "アルゴリズムとデータ構造")
Category.create(name: "キャリアアドバイス")
Category.create(name: "プロジェクトアイデア")