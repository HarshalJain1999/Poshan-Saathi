class FoodEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food_entry, only: %i[edit update destroy]

  def index
    @food_entries = current_user.food_entries
                                .order(eaten_on: :desc, created_at: :desc)
    @food_entry = current_user.food_entries.new(
      eaten_on: Date.current
    )
  end

  def create
    @food_entry = current_user.food_entries.new(food_entry_params)

    if @food_entry.save
      redirect_to food_entries_path, notice: "Food entry saved successfully."
    else
      @food_entries = current_user.food_entries
                                  .order(eaten_on: :desc, created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @food_entry.update(food_entry_params)
      redirect_to food_entries_path, notice: "Food entry updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @food_entry.destroy
    redirect_to food_entries_path, notice: "Food entry deleted successfully."
  end

  private

  def set_food_entry
    @food_entry = current_user.food_entries.find(params[:id])
  end

  def food_entry_params
    params.require(:food_entry).permit(
      :meal_type,
      :food_name,
      :food_group,
      :quantity,
      :eaten_on
    )
  end
end
