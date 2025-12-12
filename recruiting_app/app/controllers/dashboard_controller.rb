class DashboardController < ApplicationController
  before_action :require_login
  layout false, only: [:recruiting_services]
  
  def index
  end
  
  def recruiting_services
  end
end
