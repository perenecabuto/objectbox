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
      format.json { render :json => { :ok => r != false } }
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
    puts @json
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
  end

  def json_to_postit
    params[:board] ||= {}
    params[:board][:title] = params.delete(:title)
    params[:board][:background] = params.delete(:background)
    params[:board][:postits_attributes] = params.delete(:elements) || []
  end
end
