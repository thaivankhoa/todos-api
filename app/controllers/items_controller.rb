class ItemsController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_todo
  before_action :set_todo_item, only: [:show, :update, :destroy]

  def index
    render json: @todo.items, status: :ok
  end

  def show
    render json @item, status: :ok
  end

  def create
    @todo.items.create!(item_params)
    render json: @todo, status: :created
  end

  def update
    @item.update(item_params)
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :done)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_item
    @item = @todo.items.find_by!(id: params[:id]) if @todo
  end
end
