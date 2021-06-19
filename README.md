
# Task 
| カラム名 | データ型 |
| ---- | ---- |
| user_id | index |
| task_name | string |
| derails | text |
| deadline | date |
| priority | integer |
| status | string |

# User
| カラム名 | データ型 |
| ---- | ----|
| name | string |
| email | string |
| password_digest | string |

# LabelLink
| カラム名 | データ型 |
| ---- | ---- |
| task_id | index |
| label_id | index |

# Label
| カラム名 | データ型 |
| ---- | ---- |
| label_name | string |


# Herokuへのデプロイ手順

Rubyのバーション：2.6.5

1. herokuを作成する。  
   % heroku create

2. アセットプリコンパイル
   $ rails assets:precompile RAILS_ENV=production

3. エラーが出るので  
   % bundle lock --add-platform x86_64-linux

4. % git add .

5. % git commit -m "メッセージ"

6. リモートリポジトリの参照先を追加
   % git remote add heroku https://git.heroku.com/pacific-ravine-05590.git 

7. % git push heroku-18 step2:master

8. テーブルを作成する  
   $ heroku run rails db:migrate

9. アプリ名を確認  
   % heroku config