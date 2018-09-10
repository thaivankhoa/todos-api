class TodosController < ApplicationController
  before_action :set_todo, only: [:show]

  def index
    @todos = Todo.all
    render json: TodoSerializer.new(@todos).serializable_hash, status: :ok
  end

  def show
    render json: TodoSerializer.new(@todo).serializable_hash, status: :ok
  end

  private
  def set_todo
    begin
      @todo = Todo.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        error: e.to_s
      }, status: :not_found
    end
  end

  def todo_params
    prams.require(:todo).permit(:title, :created_by)
  end
end
