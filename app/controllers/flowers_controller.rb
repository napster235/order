class FlowersController < ApplicationController
  before_action :load_record, only: [:edit, :update, :destroy]

  def index
    @flowers = Flower.all
  end

  def new
    @flower = Flower.new
  end

  def create
    @flower = Flower.new(flower_params)
    if @flower.save
      flash[:notice] = "Flower successfully saved"
      redirect_to flowers_url
    else
      flash[:alert] = "Flower could not be saved"
      render :new
    end
  end

  def edit
  end

  def update
    if @flower.update(flower_params)
      flash[:notice] = "Flower successfully updated"
      redirect_to flowers_url
    else
      flash[:alert] = "Flower could not be updated"
      render :edit
    end
  end

  def destroy
    if @flower.destroy
      flash[:notice] = "Flower was deleted"
    else
      flash[:alert] = "Flower was not deleted"
    end
    redirect_to flowers_url
  end

    private

    def flower_params
      params.require(:flower).permit(:name, :price)
    end

    def load_record
      @flower = Flower.where(id: params[:id]).first
      redirect_to flowers_url if @flower.blank?
    end
end
