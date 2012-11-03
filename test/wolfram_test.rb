require File.join(File.dirname(__FILE__), 'test_helper')

module Wolfram
  describe "Wolfram" do
    def wolfram(input)
      Wolfram.run input.split(/\s+/)
    end

    describe "#run" do
      it "with no query returns usage" do
        capture_stdout { wolfram('') }.should =~ /^Usage: wolfram/
      end

      it "with normal query returns output" do
        mock(Query).fetch(anything) { read_fixture('boston') }
        capture_stdout { wolfram 'boston' }.should =~ /boston/i
      end

      it "with invalid response prints error" do
        mock(Query).fetch(anything) { ' ' }
        capture_stderr { wolfram 'boston' }.should =~ /^Wolfram Error:.*queryresult/
      end

      it "with no appid prints error" do
        val = Wolfram.appid
        Wolfram.appid = nil
        capture_stderr { wolfram 'boston' }.should =~ /Wolfram Error:.*APPID/
        Wolfram.appid = val
      end
    end
  end
end
