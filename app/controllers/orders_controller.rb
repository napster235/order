class OrdersController < ApplicationController
  include Pagy::Backend

  before_action :load_record, only: [:edit, :update, :destroy]

  def index
    @q = Order.ransack(ransack_params)
    @pagy, @orders = pagy(Order.where(user_id: current_user.id).includes(:flowers).ransack(ransack_params).result.order("status DESC"), items: 10)
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = "Order successfully saved"
      redirect_to orders_url
    else
      flash[:alert] = "Order could not be saved"
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      flash[:notice] = "Order successfully updated"
      redirect_to orders_url
    else
      flash[:alert] = "Order could not be updated"
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:notice] = "Order was deleted"
    else
      flash[:alert] = "Order was not deleted"
    end
    redirect_to orders_url
  end

  private

    def order_params
      params.require(:order).permit(:order_number, :status, :flower_ids).with_defaults(user_id: current_user.id)
    end

    def load_record
      @order = Order.where(id: params[:id]).first
      redirect_to orders_url if @order.blank?
    end

    def ransack_params
      (params[:q] || {}).merge(
        { order_number_or_status_cont: params.dig(:q, :search_query).to_s }
      )
    end
end
