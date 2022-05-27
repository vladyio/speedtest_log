require_relative 'sql_manager'
require_relative 'null_output'

class ResultLogger
  attr_reader :parsed_output, :sql_manager

  DEFAULT_RESULT_ROWS_COUNT = 10

  def initialize(parsed_output: NullOutput.new, sql_manager: SQLManager)
    @parsed_output = parsed_output
    @sql_manager = sql_manager.new
  end

  def log
    sql_manager.insert(
      download: parsed_output.download,
      upload: parsed_output.upload,
      latency: parsed_output.latency
    )
  end

  def show(last:)
    last = last.zero? ? DEFAULT_RESULT_ROWS_COUNT : last

    rows = sql_manager.select_all(limit: last)
    rows.each { |row| puts row[1..].join("\t") }
  end
end
