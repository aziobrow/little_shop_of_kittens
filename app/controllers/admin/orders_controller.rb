class Admin::OrdersController < ApplicationController

  before_action :require_login, :require_admin

  def show
    @order = Order.find(params[:id])
  end

private

  def require_admin
    not_found unless current_user.admin?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end