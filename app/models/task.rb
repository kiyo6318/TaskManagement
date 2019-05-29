class Task < ApplicationRecord
  validates :title,presence: true,length:{maximum:50}
  validates :content,presence: true,length:{maximum:150}
  belongs_to :user
  has_many :task_labels,dependent: :destroy
  has_many :labels,through: :task_labels,source: :label

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
    deadline_sort = false,
    priority_sort = false
    )
    if deadline_sort
      return Task.deadline_desc
    elsif priority_sort
      return Task.priority_asc
    else
      return Task.created_at_desc
    end
  end
  # def self.sortings(
  #      sort = false
  #   )
  #   if sort
  #     return Task.deadline_desc
  #   else
  #     return Task.created_at_desc
  #   end
  # end

  enum priority:{high:0,moderate:1,low:2}

  scope :created_at_desc, -> {all.order(created_at: :desc)}
  scope :deadline_desc, -> {all.order(deadline: :desc)}
  scope :priority_asc, -> {all.order(priority: :asc)}
  scope :title_status_like_where, -> (params1,params2){where("title LIKE ? AND status LIKE ?","%#{params1}%","%#{params2}%")}
  scope :title_like_where, -> (params){where("title LIKE ?","%#{params}%")}
  scope :status_like_where, -> (params){where("status LIKE ?","%#{params}%")}
end