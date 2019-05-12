# READ ME
### environment
Ruby 2.6.2
Rails 5.2.3
psql 11.2
### How to deploy
1. heroku login
2. heroku create
3. git push heroku master
4. heroku run rails db:migrate

### User
カラム名 | データ型
--- | ---
name | string
email | string
password_digest | string
### Task
カラム名 | データ型
--- | ---
user_id | references
title | string
content | text
deadline | datetime
priority | integer
status | string
### Label
カラム名 | データ型
--- | ---
category | string
### Task_Label
カラム名 | データ型
--- | ---
task_id(FK) | references
label_id(FK) | references