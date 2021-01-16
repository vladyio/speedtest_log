class SpeedTest
  attr_reader :command_output

  def initialize
    @command_output = nil
  end

  def run
    @command_output = %x{speedtest}
  end
end
