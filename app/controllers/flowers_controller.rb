class FlowersController < ApplicationController
  include Pagy::Backend

  before_action :load_record, only: [:edit, :update, :destroy]

  def index
    @q = Flower.ransack(ransack_params)
    @pagy, @flowers = pagy(Flower.where(user_id: current_user.id).ransack(ransack_params).result.order("price ASC"), items: 10)
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
        params.require(:flower).permit(:name, :price, order_ids: []).with_defaults(user_id: current_user.id)
      end

      def load_record
        @flower = Flower.where(id: params[:id]).first
        redirect_to flowers_url if @flower.blank?
      end

      def ransack_params
        (params[:q] || {}).merge(
          { name_or_price_cont: params.dig(:q, :search_query).to_s }
        )
      end
end
