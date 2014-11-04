module CalendarsHelper

	def month_and_year(month,year,numberof)
		#if month.empty?
		#	"error"
		#else
			case month
			when 1
				"(#{numberof}) January, #{year}"
			when 2
				"(#{numberof}) February, #{year}"
			when 3
				"(#{numberof}) March, #{year}"
			when 4
				"(#{numberof}) April, #{year}"
			when 5
				"(#{numberof}) May, #{year}"
			when 6
				"(#{numberof}) June, #{year}"
			when 7
				"(#{numberof}) July, #{year}"
			when 8
				"(#{numberof}) August, #{year}"
			when 9
				"(#{numberof}) September, #{year}"
			when 10
				"(#{numberof}) October, #{year}"
			when 11
				"(#{numberof}) November, #{year}"
			when 12
				"(#{numberof}) December, #{year}"
			else
				"Incorrect month in a post"
			end
		#end
	end
end


