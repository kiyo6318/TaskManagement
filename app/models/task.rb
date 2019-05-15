class Task < ApplicationRecord
  validates :title,presence: true,length:{maximum:50}
  validates :content,presence: true,length:{maximum:150}

  def self.searchings(
       title = nil,
       status = nil
    )
    if title.present? && status.present?
      return Task.title_status_like_where(title,status)
    elsif title.empty? && status.present?
      return Task.status_like_where(status)
    elsif title.present? && status.empty?
      return Task.title_like_where(title)
    else
      return Task.created_at_desc
    end
  end

  def self.sortings(
       sort = false
    )
    if sort
      return Task.deadline_desc
    else
      return Task.created_at_desc
    end
  end

  scope :created_at_desc, -> {all.order(created_at: :desc)}
  scope :deadline_desc, -> {all.order(deadline: :desc)}
  scope :title_status_like_where, -> (params1,params2){where("title LIKE ? AND status LIKE ?","%#{params1}%","%#{params2}%")}
  scope :title_like_where, -> (params){where("title LIKE ?","%#{params}%")}
  scope :status_like_where, -> (params){where("status LIKE ?","%#{params}%")}
end
