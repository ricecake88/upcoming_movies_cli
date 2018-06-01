require 'date'
require 'time'

module Helper
    @@months = {'January'=>'01', 
        'February'=>'02', 
        'March'=>'03', 
        'April'=>'04', 
        'May'=>'05', 
        'June'=>'06', 
        'July'=>'07', 
        'August'=>'08', 
        'September'=>'09', 
        'October'=>'10', 
        'November'=>'11', 
        'December'=>'12'}

    def date_of_next_or_this_friday
        date  = Date.parse("Friday")
        delta = date >= Date.today ? 0 : 7
        [(date + delta).strftime("%m"), (date+delta).strftime("%d"), (date+delta).strftime("%Y")]
    end

    def current_month_year
        monthNo =  Date.today.strftime("%m")
        currentYear = Date.today.strftime("%Y")
        monthString = @@months.key(monthNo)
        [monthString, currentYear]
    end

    def self.months
        @@months
    end
end