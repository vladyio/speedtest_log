class SpeedtestLogQuery
  attr_reader :relation, :params

  def initialize(relation: SpeedtestLog, **params)
    @relation = relation
    @params = params
  end

  def call
    relation.where('timestamp >= ? AND timestamp < ?', datetime_from, datetime_to)
  end

  private

  def datetime_from
    param_from = params.dig('date', 'from')

    if param_from.nil?
      Date.today.to_time.strftime('%Y-%m-%d %H:%M')
    else
      Time.parse(param_from, '%d %b %Y %H:%m').strftime('%Y-%m-%d %H:%M')
    end
  end

  def datetime_to
    param_to = params.dig('date', 'to')

    if param_to.nil?
      Time.now.strftime('%Y-%m-%d %H:%M')
    else
      Time.parse(param_to, '%d %b %Y %H:%m').strftime('%Y-%m-%d %H:%M')
    end
  end
end
