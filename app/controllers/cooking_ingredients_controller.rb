# -*- encoding : utf-8 -*-
class CookingIngredientsController < ApplicationController
  before_filter :load_ingredient, :only => [:show, :edit, :update, :destroy]
  before_filter :associate_recipe, :only => [:show, :new, :edit, :update, :create]

  # GET /cooking_ingredients
  # GET /cooking_ingredients.xml
  def index
    @cooking_ingredients = CookingIngredient.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @cooking_ingredients }
    end
  end

  # GET /cooking_ingredients/1
  # GET /cooking_ingredients/1.xml
  def show
    @cooking_ingredient = CookingIngredient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @cooking_ingredient }
    end
  end

  # GET /cooking_ingredients/new
  # GET /cooking_ingredients/new.xml
  def new
    @cooking_ingredient = CookingIngredient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @cooking_ingredient }
    end
  end

  # GET /cooking_ingredients/1/edit
  def edit
  end

  # POST /cooking_ingredients
  # POST /cooking_ingredients.xml
  def create
    @cooking_ingredient ||= CookingIngredient.new(params[:cooking_ingredient])

    respond_to do |format|
      if @cooking_ingredient.save
        format.html {
          if @cooking_recipe
            redirect_to(edit_cooking_recipe_path(@cooking_recipe), :notice => 'CookingIngredient was successfully updated.')
          else
            redirect_to(@cooking_ingredient, :notice => 'CookingIngredient was successfully updated.')
          end
        }
        format.xml { render :xml => @cooking_ingredient, :status => :created, :location => @cooking_ingredient }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @cooking_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cooking_ingredients/1
  # PUT /cooking_ingredients/1.xml
  def update
    respond_to do |format|
      if @cooking_ingredient.update_attributes(params[:cooking_ingredient])
        format.xml { head :ok }
        format.html {
          if @cooking_recipe
            redirect_to(edit_cooking_recipe_path(@cooking_recipe))
          else
            redirect_to(@cooking_ingredient, :notice => 'CookingIngredient was successfully updated.')
          end
        }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @cooking_ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cooking_ingredients/1
  # DELETE /cooking_ingredients/1.xml
  def destroy
    @cooking_ingredient.destroy

    respond_to do |format|
      format.html { redirect_to(cooking_ingredients_url) }
      format.xml { head :ok }
    end
  end

  private

  def load_ingredient
    @cooking_ingredient = CookingIngredient.find(params[:id])
  end

  def associate_recipe
    @cooking_ingredient ||= CookingIngredient.new(params[:cooking_ingredient])
    @cooking_recipe = CookingRecipe.find_by_id(params[:cooking_recipe_id])
    @cooking_ingredient.cooking_recipes << @cooking_recipe if @cooking_recipe and @cooking_ingredient
  end
end
