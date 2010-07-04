class PostitsController < ApplicationController
  before_filter :load_postit, :only => [:show, :edit]

  def index
      @board  = Board.find(params[:board_id])
      redirect_to @board
  rescue ActiveRecord::RecordNotFound
    redirect_to :boards
  end

  def show
  end

  def edit
    redirect_to edit_board_path(@postit.board) + "#postit-#{@postit.id}"
  end

  private
  def load_postit
    @postit = Postit.find(params[:id])
  end
end
