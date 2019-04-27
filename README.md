# READ ME
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