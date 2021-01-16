class ParsedOutput
  LATENCY_REGEXP = %r{Latency:\s+(\d+\.\d+ \w+)}.freeze
  DOWNLOAD_REGEXP = %r{Download:\s+(\d+\.\d+ \w+)}.freeze
  UPLOAD_REGEXP = %r{Upload:\s+(\d+\.\d+ \w+)}.freeze

  attr_reader :command_output

  def initialize(command_output)
    @command_output = command_output
  end

  def download
    command_output.match(DOWNLOAD_REGEXP)[0]
  end

  def upload
    command_output.match(UPLOAD_REGEXP)[0]
  end

  def latency
    command_output.match(LATENCY_REGEXP)[0]
  end
end
