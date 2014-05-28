require 'uri'
require 'clamp'
require 'colorize'

require 'zapr/version'
require 'zapr/zap'
require 'zapr/lib'

module Zapr

  class Command < Clamp::Command

    option "--debug", :flag, "More verbose output", :default => false
    option "--summary", :flag, "Output a summary of the results instead of JSON", :default => false
    option "--zap-path", "PATH", "Path to zap.sh startup script", :environment_variable => "ZAP_PATH"
    option "--timeout", "TIMEOUT", "Timeout for spider and scan", :default => 300, :environment_variable => "ZAPR_TIMEOUT" do |timeout|
      Integer(timeout)
    end

    parameter "TARGET", "Web address to scan and attack with ZAP", :attribute_name => :target

    def execute
      signal_usage_error "Path to ZAP does not exist" unless File.file?(zap_path)
      signal_usage_error "Invalid target URL" unless target =~ /\A#{URI::regexp(['http', 'https'])}\z/
      begin
        zap = Zapr::Proxy.new(target, zap_path, timeout)
        debug? ? zap.start : dev_null { zap.start }
        zap.spider
        zap.attack
        puts summary? ? zap.summary : zap.alerts
      rescue Timeout::Error
        puts "=====> Timeout".red
        puts "the execution of the spider or scan took too long"
      rescue Exception => e
        puts "=====> An error occured".red
        puts e.message
      ensure
        zap.shutdown if defined? zap
      end
    end

  end

end
