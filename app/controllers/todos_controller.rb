class TodosController < ApplicationController
  include ExceptionHandler
  before_action :set_todo, only: [:show]

  def index
    @todos = Todo.all
    render json: TodoSerializer.new(@todos).serializable_hash, status: :ok
  end

  def show
    render json: TodoSerializer.new(@todo).serializable_hash, status: :ok
  end

  def create
    @todo = Todo.create!(todo_params)
    render json: TodoSerializer.new(@todo).serializable_hash, status: :created
  end

  private
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.permit(:title, :created_by)
  end
end
