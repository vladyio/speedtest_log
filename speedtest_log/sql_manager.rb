class SQLManager
  DATABASE_FILENAME = 'speedtest_log.db'.freeze
  LOG_TABLE_NAME = 'speedtest_log'.freeze

  def insert(**results)
    create_table_if_not_exists

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
    create_table_if_not_exists

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

  def create_table_if_not_exists
    with_db do |db|
      db.execute(<<-SQL)
        CREATE TABLE IF NOT EXISTS #{LOG_TABLE_NAME}(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timestamp DATETIME,
          download FLOAT,
          upload FLOAT,
          latency FLOAT
        )
      SQL
    end
  end

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
