class ApplicationController < Sinatra::Base
  helpers do
    def safe_json(json_string)
      Rack::Utils.escape_html(json_string)
    end
  end

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
