class SQLManager
  DATABASE_FILENAME = 'speedtest_log.db'.freeze
  LOG_TABLE_NAME = 'speedtest_log'.freeze

  def insert(**results)
    results['timestamp'] = "'#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}'"
    values = results.values.map { |v| "#{v}" }.join(', ')
    columns = results.keys.map { |c| "'#{c}'" }.join(', ')

    with_db do |db|
      db.execute(<<-SQL)
        INSERT INTO #{LOG_TABLE_NAME}(#{columns}) VALUES(#{values})
      SQL
    end
  end

  def select_all(limit:)
    rows = []

    with_db do |db|
      rows = db.execute(<<-SQL)
        SELECT * FROM #{LOG_TABLE_NAME}
        ORDER BY timestamp DESC
        LIMIT #{limit}
      SQL
    end

    rows
  end

  private

  def with_db(&block)
    connection = SQLite3::Database.open(
      File.join(
        File.dirname(File.dirname(__FILE__)),
        DATABASE_FILENAME
      )
    )
    yield(connection)
    connection.close
  end
end
