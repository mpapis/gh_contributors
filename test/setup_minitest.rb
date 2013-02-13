if ENV["COVERAGE"]
  begin
    require "simplecov"
    SimpleCov.command_name("minitest") and SimpleCov.start
  rescue
    $stderr.puts "Coverage being skipped, unable to load or start."
  end
end

%w(test/unit mocha/setup).each { |f| require f }
