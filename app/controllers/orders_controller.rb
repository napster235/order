class OrdersController < ApplicationController
  before_action :load_records, only: [:index]
  before_action :load_record, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:success] = "Order successfully saved"
      redirect_to orders_url
    else
      flash[:error] = "Order could not be saved"
      render :new
    end
  end

  def edit
  end

  def update
    # binding.pry
    if @order.update(order_params)
      flash[:success] = "Order successfully updated"
      redirect_to orders_url
    else
      flash[:error] = "Order could not be updated"
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = "Order was deleted"
    else
      flash[:error] = "Order was not deleted"
    end
    redirect_to orders_url
  end

  private

    def order_params
      params.require(:order).permit(:order_number, :user_id, :status)
    end

    def load_records
      @orders = Order.all
    end

    def load_record
      @order = Order.where(id: params[:id]).first
      redirect_to orders_url if @order.blank?
    end
end
