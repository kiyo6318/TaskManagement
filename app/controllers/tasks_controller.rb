class TasksController < ApplicationController
  before_action :set_task,only: %i(show edit destroy update)
  def index
    @tasks =
    if params[:search] == "true"
      Task.searchings(
        params[:title_search],
        params[:status_search]
        ).page(params[:page]).per(12)
    else
      Task.sortings(
        params[:sort_expired],
        params[:sort_priority]
        ).page(params[:page]).per(12)
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
  params.require(:task).permit(:title,:content,:deadline,:status,:priority)
end

def set_task
  @task = Task.find(params[:id])
end
end
