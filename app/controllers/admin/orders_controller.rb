class Admin::OrdersController < ApplicationController

  before_action :require_admin

  def show
    @order = Order.find(params[:id])
  end

  def index
    @status = params[:status]
    @orders = Order.by_status(@status)
  end

end
