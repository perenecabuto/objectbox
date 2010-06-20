class SimpletextsController < ApplicationController
  before_filter :login_required
  before_filter :load_simpletext, :only => [:show, :edit, :destroy, :update]
  before_filter :breadcrumbs


  # GET /simpletexts
  # GET /simpletexts.xml
  def index
    @simpletexts = Simpletext.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @simpletexts }
    end
  end

  # GET /simpletexts/1
  # GET /simpletexts/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @simpletext }
    end
  end

  # GET /simpletexts/new
  # GET /simpletexts/new.xml
  def new
    @simpletext = Simpletext.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @simpletext }
    end
  end

  # GET /simpletexts/1/edit
  def edit
  end

  # POST /simpletexts
  # POST /simpletexts.xml
  def create
    @simpletext = Simpletext.new(params[:simpletext])

    respond_to do |format|
      if @simpletext.save
        flash[:notice] = 'Simpletext was successfully created.'
        format.html { redirect_to(@simpletext) }
        format.xml  { render :xml => @simpletext, :status => :created, :location => @simpletext }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @simpletext.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /simpletexts/1
  # PUT /simpletexts/1.xml
  def update
    respond_to do |format|
      if @simpletext.update_attributes(params[:simpletext])
        flash[:notice] = 'Simpletext was successfully updated.'
        format.html { redirect_to(@simpletext) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @simpletext.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /simpletexts/1
  # DELETE /simpletexts/1.xml
  def destroy
    @simpletext.destroy

    respond_to do |format|
      format.html { redirect_to(simpletexts_url) }
      format.xml  { head :ok }
    end
  end

  private
  def load_simpletext
    @simpletext = Simpletext.find(params[:id])
  end

  def breadcrumbs
    add_crumb :label => controller_name, :controller => :simpletexts
    add_crumb :label => action_name, :controller => :simpletexts if action_name != 'index'
    add_crumb @simpletext if @simpletext and not @simpletext.new_record?
  end
end
