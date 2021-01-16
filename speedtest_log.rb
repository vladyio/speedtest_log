#!/usr/bin/env ruby

require 'sqlite3'

require_relative 'speedtest_log/speedtest'
require_relative 'speedtest_log/parsed_output'
require_relative 'speedtest_log/result_logger'

if ARGV[0] == 'show'
  ResultLogger.new.show

  return
end

speedtest = SpeedTest.new.run
parsed_output = ParsedOutput.new(speedtest)
ResultLogger.new(parsed_output: parsed_output).log
