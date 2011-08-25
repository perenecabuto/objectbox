# -*- encoding : utf-8 -*-
class CookingRecipesController < ApplicationController
  before_filter :convert_difficult_to_i, :only => [:create, :update]

  # GET /cooking_recipes
  # GET /cooking_recipes.xml
  def index
    @cooking_recipes = CookingRecipe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cooking_recipes }
    end
  end

  # GET /cooking_recipes/1
  # GET /cooking_recipes/1.xml
  def show
    @cooking_recipe = CookingRecipe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cooking_recipe }
    end
  end

  # GET /cooking_recipes/new
  # GET /cooking_recipes/new.xml
  def new
    @cooking_recipe = CookingRecipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cooking_recipe }
    end
  end

  # GET /cooking_recipes/1/edit
  def edit
    @cooking_recipe = CookingRecipe.find(params[:id])
  end

  # POST /cooking_recipes
  # POST /cooking_recipes.xml
  def create
    @cooking_recipe = CookingRecipe.new(params[:cooking_recipe])

    respond_to do |format|
      if @cooking_recipe.save
        format.html { redirect_to(@cooking_recipe, :notice => 'CookingRecipe was successfully created.') }
        format.xml  { render :xml => @cooking_recipe, :status => :created, :location => @cooking_recipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cooking_recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cooking_recipes/1
  # PUT /cooking_recipes/1.xml
  def update
    @cooking_recipe = CookingRecipe.find(params[:id])

    respond_to do |format|
      if @cooking_recipe.update_attributes(params[:cooking_recipe])
        format.html { redirect_to(@cooking_recipe, :notice => 'CookingRecipe was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cooking_recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cooking_recipes/1
  # DELETE /cooking_recipes/1.xml
  def destroy
    @cooking_recipe = CookingRecipe.find(params[:id])
    @cooking_recipe.destroy

    respond_to do |format|
      format.html { redirect_to(cooking_recipes_url) }
      format.xml  { head :ok }
    end
  end

  private

  def convert_difficult_to_i
    params[:cooking_recipe][:difficult] = params[:cooking_recipe][:difficult].to_i if params[:cooking_recipe].has_key? :difficult
    logger.info params[:cooking_recipe][:difficult].class
  end
end
