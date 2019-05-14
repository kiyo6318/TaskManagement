class Task < ApplicationRecord
  validates :title,presence: true,length:{maximum:50}
  validates :content,presence: true,length:{maximum:150}

  scope :created_at_desc, -> {all.order(created_at: :desc)}
  scope :deadline_desc, -> {all.order(deadline: :desc)}
  scope :title_status_like_where, -> (params1,params2){where("title LIKE ? AND status LIKE ?","%#{params1}%","%#{params2}%")}
  scope :title_like_where, -> (params){where("title LIKE ?","%#{params}%")}
  scope :status_like_where, -> (params){where("status LIKE ?","%#{params}%")}
end
