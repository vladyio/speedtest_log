class ApplicationController < Sinatra::Base
  configure do
    set :views, -> { File.join(root, '..', 'views') }
  end

  get '/' do
    @speedtest_logs = SpeedtestLogQuery.new(**params).call
    @chart_data = SpeedtestChartDataService.new(@speedtest_logs).call
    slim :index
  end
end
