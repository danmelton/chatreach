class TextReport
  attr_accessor :start_date, :end_date, :account, :brand, :report_date_type, :total_time, :time_array, :time_array_pipes
  
  def initialize(options)
    @start_date = options[:start_date].to_time
    @end_date = options[:end_date].to_time
    @brand = options[:brand]
    @account = options[:account]
    @hour_in_seconds = 60*60
    @day_in_seconds = 60*60*24
    @week_in_seconds = 60*60*24*7    
    @month_in_seconds = 60*60*24*30 
    @total_time = @end_date - @start_date   
    date_array
    @time_array = convert_to_time_array
    @time_array_pipes = @time_array.join('|')
  end
  
  def total_new_chatters
    @account.text_sessions.between_created_dates(@start_date, @end_date)
  end
  
  def total_new_chatters_graph
    new_data_array = convert_to_data_array(:data_array => total_new_chatters, :date_column_name => "created_at")
    return line_chart(
      :size => '500x250',
      :title => "New Chatters | from #{@start_date.strftime("%B %d, %Y")} to #{@end_date.strftime("%B %d, %Y")}", 
      :data => [new_data_array],
      :axis_with_labels => ['x','y'],
      :axis_labels => [@time_array_pipes, "0|#{new_data_array.max/2}|#{new_data_array.max}"] 
    )
  end
  
  def total_chatters
    @account.text_sessions.between_updated_dates(@start_date, @end_date)
  end
  
  def total_chatters_graph
    new_data_array = convert_to_data_array(:data_array => total_chatters, :date_column_name => "updated_at")
    return line_chart(
      :size => '500x250',
      :title => "Total Chatters | from #{@start_date.strftime("%B %d, %Y")} to #{@end_date.strftime("%B %d, %Y")}", 
      :data => [new_data_array],
      :axis_with_labels => ['x','y'],
      :axis_labels => [@time_array_pipes, "0|#{new_data_array.max/2}|#{new_data_array.max}"]
    )
  end
  
  def total_content
    TextHistory.between_created_dates(@account.id, @start_date, @end_date)
  end
  
  def total_content_graph
    new_data_array = convert_to_data_array(:data_array => total_content, :date_column_name => "created_at")
    return line_chart(
      :size => '500x250',
      :title => "Total Content Delivered | from #{@start_date.strftime("%B %d, %Y")} to #{@end_date.strftime("%B %d, %Y")}", 
      :data => [new_data_array],
      :axis_with_labels => ['x','y'],
      :axis_labels => [@time_array_pipes, "0|#{new_data_array.max/2}|#{new_data_array.max}"] 
    )
  end
  

  
  def line_chart(options)
    # sample axis labels ['Jan|July|Jan|July|Jan', '0|100', 'A|B|C', '2005|2006|2007'] 
   return Gchart.line(
                :title_size => 18,
                :title_color => "EA2E02",                                
                :data => options[:data], 
                :title => options[:title],
                :size => options[:size],
                :axis_with_labels => options[:axis_with_labels],
                :axis_labels => options[:axis_labels]
                )
  end
  
  # function determines whether to show data in hours, days, weeks, or months
  def date_array

    case @total_time
      when (35 * @day_in_seconds)..(6*@month_in_seconds)
        @report_date_type = [@week_in_seconds,'week']     
      when (2 * @day_in_seconds)..(35 * @day_in_seconds)
        @report_date_type = [@day_in_seconds,'day']
      when 0..(2*@day_in_seconds)
        @report_date_type = [@hour_in_seconds, 'hour']
      else
        @report_date_type = [@month_in_seconds,'month']          
    end
  end
  
  # returns data with pipes inbetween each
  def convert_to_data_array(options)
    data_array = options[:data_array]
    date_column_name = options[:date_column_name]
    # setup the interval
    interval = @report_date_type[0]
    interval_key = (@total_time/interval).round
    @return_array = []
    @return_array = Array.new(interval_key+1,0)
    data_array.each do |data_point|
     current_key = ((eval("data_point.#{date_column_name}") - @start_date)/interval).round
     @return_array[current_key] += 1
    end
    return @return_array
  end
  
  def convert_to_time_array
    interval = @report_date_type[0]
    interval_key = (@total_time/interval).round
    @return_array = []
    @return_array = Array.new(interval_key+1,0)
    case @report_date_type[1]
    when "month"
      interval_key.times do |t|
        @return_array[t] = (@start_date + t.month).strftime("%m/%d")
      end
      @return_array[interval_key] = @end_date.strftime("%m/%d")                    
    when "week"
      interval_key.times do |t|
        @return_array[t] = (@start_date + (t * 7).days).strftime("%m/%d")
      end
      @return_array[interval_key] = @end_date.strftime("%m/%d")      
    when "day"
      interval_key.times do |t|
        @return_array[t] = (@start_date + t.days).day
      end
      @return_array[interval_key] = @end_date.day
    when "hour"
      interval_key.times do |t|
        @return_array[t] = (@start_date + t.hours).hour
      end
      @return_array[interval_key] = @end_date.hour
    end

    return @return_array  
    
  end
  
end