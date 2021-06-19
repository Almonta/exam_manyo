
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

1. バージョン18を指定してherokuを作成する。
  % heroku create --remote heroku-18 --stack heroku-18

2. エラーが出るので
  % bundle lock --add-platform x86_64-linux

3. % git add .

4. % git commit -m "メッセージ"

5. % git push heroku-18 step2:master