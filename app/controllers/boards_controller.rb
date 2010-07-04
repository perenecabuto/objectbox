class BoardsController < ApplicationController
  before_filter :load_board, :only => [:edit,:update]
  before_filter :json_to_postit, :only => [:create, :update]
  before_filter :build_board, :only => [:new,:update,:create]

  def index
    @boards = Board.all
  end

  def new
  end

  def show
    redirect_to :action => :edit, :id => params[:id]
  end

  def create
    @board.background ||= 'glossymetal.jpg';
    r = save
    respond_to do|format|
      format.html { redirect_to edit_board_path(@board) }
      format.json { render :json => { :ok => r != false, :id => @board.id } }
    end
  end

  def edit
    @hash = {
      "_rev" => @board.id,
      :title => @board.title,
      :background => @board.background,
      :elements => @board.postits.collect {|p| p.attributes }
    }

    @json = @hash.to_json
  end

  def update
    respond_to do|format|
      r = save
      format.json { render :json => { :ok => r != false } }
    end
  end

  private

  def build_board
    @board ||= Board.new
    @board.attributes = params[:board]
  end

  def load_board
    @board = Board.find(params[:id])
  end

  def save
    if @board.save
      flash[:notice] = 'Salvo com sucesso'
    else
      render :action => :new
      return false
    end

    @board.postits.each do |p|
      unless params[:board][:postits_attributes].any? {|item| !item.has_key? :id or item[:id].to_i == p.id}
        p.destroy
      end
    end
  end

  def json_to_postit
    params[:board] ||= {}
    params[:board][:title] = params.delete(:title)
    params[:board][:background] = params.delete(:background)
    params[:board][:postits_attributes] = params.delete(:elements).values unless params[:elements].nil?
    params[:board][:postits_attributes] ||= []
  end
end
