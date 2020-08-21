class CategoryController < ApplicationController
  before_action :authorized

  def index
    @categories = Category.where(user_id: @user.id)
    if @categories.empty?
      render :json => {
          :error => 'There is no categories to show.'
      }
    else
      if @categories[0].user_id == @user.id
        render :json => {
          :response => 'Here are all the categories.',
          :data => @categories
      }
      else
        render :json => {
            :response => 'There are no categories.',
            :data => @user.id
        }
      end
    end
  end

  def create
    @one_category = Category.new(category_params)
    @one_category.user_id = @user.id
    @one_category.created_by = @user.id
    if @one_category.save
      render :json => {
          :response => 'Successfully created the category list',
          :data => @one_category
      }
    else
      render :json => {
          :error => 'Cannot save the category'
      }
    end
  end

  def show
    @single_category = Category.exists?(params[:id])
    if @single_category && (@show_category = Category.find(params[:id])).user_id == @user.id
      render :json => {
          :response => 'Successful',
          :data => @show_category
      }
    else
      render :json => {
          :response => 'Record not found'
      }
    end
  end

  def update
    if (@single_category_update = Category.find_by_id(params[:id])).present? && (@update_category = Category.find(params[:id])).user_id == @user.id
      @update_category.update(category_params)
      render :json => {
          :response => 'Successfully updated category',
          :data => @update_category
      }
    else
      render :json => {
          :response => 'Cannot update the selected category'
      }
    end
  end

  def destroy
    if (@destroy_category = Category.find_by_id(params[:id])).present? && (@delete_category = Category.find(params[:id])).user_id == @user.id
      @delete_category.destroy
      render :json => {
          :response => 'Successfully deleted category',
          :data => @destroy_category
      }
    else
      render :json => {
          :response => 'Cannot delete the selected category'
      }
    end
  end

  private
  def category_params
    params.permit(:title, :description, :created_by)
  end

end
