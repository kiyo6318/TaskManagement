class TasksController < ApplicationController
  before_action :set_task,only: %i(show edit destroy update)
  def index
    if params[:search] == "true"
      if params[:title_search].present? && params[:status_search].present?
        @tasks = Task.title_status_like_where(params[:title_search],params[:status_search])
      elsif params[:title_search].present? && params[:status_search].empty?
        @tasks = Task.title_like_where(params[:title_search])
      elsif params[:title_search].empty? && params[:status_search].present?
        @tasks = Task.status_like_where(params[:status_search])
      elsif params[:title_search].empty? && params[:status_search].empty?
        @tasks = Task.created_at_desc
      end
    else
      if params[:sort_expired]
        @tasks = Task.deadline_desc
      else
        @tasks = Task.created_at_desc
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path,notice:"タスクを追加しました!"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path,notice:"タスクを編集しました!"
    else
      render "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path,notice:"タスクを削除しました!"
  end

  private
  def task_params
    params.require(:task).permit(:title,:content,:deadline,:status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
