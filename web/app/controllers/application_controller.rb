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
    @speedtest_logs = SpeedtestLog.all
    @chart_data = SpeedtestChartDataService.new(@speedtest_logs).call
    slim :index
  end
end

class SpeedtestChartDataService
  attr_reader :speedtest_logs

  def initialize(speedtest_logs)
    @speedtest_logs = speedtest_logs
  end

  def call
    chart_data = { labels: [], download: [], upload: [], latency: [] }

    speedtest_logs.map do |log|
      chart_data[:labels] << log.timestamp.strftime('%d.%m.%Y %H:%M')
      chart_data[:download] << log.download
      chart_data[:upload] << log.upload
      chart_data[:latency] << log.latency
    end

    chart_data
  end
end
