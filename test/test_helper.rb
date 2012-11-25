require 'bacon'
require 'bacon/bits'
require 'rr'
require 'bacon/rr'
require 'wolfram'

Wolfram.appid = 'xxx'

module TestHelpers
  def read_fixture(name)
    path = File.expand_path("../fixtures/#{name}.xml", __FILE__)
    File.read(path)
  end

  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end

  def capture_stderr(&block)
    original_stderr = $stderr
    $stderr = fake = StringIO.new
    begin
      yield
    ensure
      $stderr = original_stderr
    end
    fake.string
  end
end

class Bacon::Context
  include TestHelpers
end
