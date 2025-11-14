class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
  end

  def create
  @list = List.new(list_params)
  if @list.save
    redirect_to new_list_bookmark_path(@list)
  else
    render :new, status: :unprocessable_entity
  end
end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
