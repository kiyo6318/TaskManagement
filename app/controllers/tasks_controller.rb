class TasksController < ApplicationController
  before_action :set_task,only: %i(show edit destroy update task_ensure_correct_user)
  before_action :task_ensure_correct_user,only: %i(show edit update destroy)
  before_action :authenticate_user
  def index
    @tasks =
    if params[:search] == "true"
      current_user.tasks.searchings(
        params[:title_search],
        params[:status_search]
        ).page(params[:page]).per(12)
    else
      current_user.tasks.sortings(
        params[:sort_expired],
        params[:sort_priority]
        ).page(params[:page]).per(12)
    end
  end

def new
  @task = Task.new
end

def create
  @task = current_user.tasks.new(task_params)
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

def task_ensure_correct_user
  if @task.user_id != current_user.id
    redirect_to user_path(current_user.id),notice:"権限がありません"
  end
end

private
def task_params
  params.require(:task).permit(:title,:content,:deadline,:status,:priority)
end

def set_task
  @task = Task.find(params[:id])
end
end
