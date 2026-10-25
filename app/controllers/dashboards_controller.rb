# class DashboardsController < ApplicationController
#   before_action :authenticate_user!

#   def index
#     if current_user.admin?
#       @dashboard_title = "Admin Dashboard"
#     else
#       @dashboard_title = "Student Dashboard"
#     end
#   end
# end


class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    unless current_user.student?
      redirect_to root_path, alert: "Student access only."
      return
    end

    @dashboard_title = "Student Dashboard"

    @today_entries = current_user.food_entries
                                 .where(eaten_on: Date.current)
                                 .order(created_at: :desc)

    @total_entries = current_user.food_entries.count

    @food_groups_count = current_user.food_entries
                                    .where(eaten_on: Date.current)
                                    .distinct
                                    .count(:food_group)
  end
end
