module AppsHelper
	def active_sort(value)
		case value
			when "day"
				"Most Viewed Today"
			when "week"
				"Most Viewed This Week"
			when "month"
				"Most Viewed This Month"
		end
	end
end
