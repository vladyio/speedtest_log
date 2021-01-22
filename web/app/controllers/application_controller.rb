class ApplicationController < Sinatra::Base
  configure do
    set :views, -> { File.join(root, '..', 'views') }
  end

  get '/' do
    @from = params[:date][:from]
    @to = params[:date][:to]
    @speedtest_logs = SpeedtestLog.where('timestamp >= ? AND timestamp < ?', @from, @to)
    @chart_data = SpeedtestChartDataService.new(@speedtest_logs).call
    slim :index
  end
end
