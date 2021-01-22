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
