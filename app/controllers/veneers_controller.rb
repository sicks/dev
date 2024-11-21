class VeneersController < ApplicationController
  before_action :set_veneer, only: %i[edit update destroy]

  def index
    @veneers = Veneer.all
  end

  def new
    @veneer = Veneer.new
  end

  def create
    @veneer = Veneer.create!(veneer_params)

    redirect_to veneers_path, notice: "Created!"
  end

  def edit
  end

  def update
    @veneer.update!(veneer_params)

    redirect_to veneers_path, notice: "Updated!"
  end

  def destroy
    @veneer.destroy!

    redirect_to veneers_path, notice: "Deleted!"
  end

  private

  def veneer_params
    params.require(:veneer).permit(:host, :title, :subtitle, :theme)
  end

  def set_veneer
    @veneer = Veneer.find(params[:id])
  end
end
