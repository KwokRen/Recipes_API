class RecipesController < ApplicationController
  before_action :authorized

  def index
    if Category.exists?(params[:category_id])
      if (@recipe_category = Category.where(user_id: @user.id, id: params[:category_id])).empty?
        render :json => {
            :response => 'There is no recipes to show.'
        }
      else
        render :json => {
            :response => 'Here are all the recipes',
            :data => @user.recipes
        }
      end
    else
      render :json => {
          :response => 'There is no category.'
      }
    end
  end

  def create
    @one_recipe = Recipe.new(recipes_params)
    if Category.exists?(@one_recipe.category_id)
      if @one_recipe.save
        render :json => {
            :response => 'Successfully created the recipe',
            :data => @one_recipe
        }
      else
        render :json => {
            :error => 'Cannot save the recipe'
        }
      end
    else
      render :json => {
          :response => 'There is no category'
      }
    end
  end

  def show
    if Category.exists?(params[:category_id])
      if (@one_recipe = Category.where(user_id: @user.id, id: params[:category_id])).present?
        if (@user_one_recipe = @user.recipes.find_by_id(params[:id]))
        render :json => {
            :response => 'Successful',
            :data => @user_one_recipe
        }
        else
          render :json => {
              :response => 'This recipe does not exist for this category.'
          }
        end
      else
        render :json => {
            :response => 'Recipe not found'
        }
      end
    else
      render :json => {
          :response => 'This category does not exist'
      }
    end
  end

  def update
    if (@single_recipe_update = Category.where(user_id: @user.id, id: params[:category_id])).present?
      if @user.recipes.find_by_id(params[:id])
        @user.recipes.find_by_id(params[:id]).update(recipes_params)
        render :json => {
            :response => 'Successfully updated recipe',
            :data => @user.recipes.find_by_id(params[:id])
        }
      else
        render :json => {
            :response => 'Cannot update the selected recipe'
        }
      end
    else
      render :json => {
          :response => 'This category does not exist'
      }
    end
  end

  def destroy
    if (@destroy_recipe = Category.where(user_id: @user.id, id: params[:category_id])).present?
      if @user.recipes.find_by_id(params[:id])
        @destroyed_recipe = @user.recipes.find_by_id(params[:id]).destroy
        render :json => {
            :response => 'Successfully deleted recipe',
            :data => @destroyed_recipe
        }
      else
        render :json => {
            :response => 'Cannot delete the selected recipe'
        }
      end
    else
      render :json => {
          :response => 'This category does not exist'
      }
    end
  end

  private
  def recipes_params
    params.permit(:name, :ingredients, :directions, :notes, :tags, :category_id)
  end

end

