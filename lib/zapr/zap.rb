require 'owasp_zap'
require 'timeout'

include OwaspZap

module Zapr

  class Proxy

    def initialize(target, zap_path, timeout)
      @proxy = Zap.new(:target => target, :zap => zap_path)
      @timeout = timeout
    end

    def start
      Timeout.timeout(@timeout) do
        @proxy.start(:daemon => true)
        sleep(1) until @proxy.running?
      end
    end


    def spider
      Timeout.timeout(@timeout) do
        @proxy.spider.start
        sleep(1) until (JSON.parse(@proxy.status_for(:spider))['status'] == '100')
      end
    end

    def attack
      Timeout.timeout(@timeout) do
        @proxy.ascan.start
        sleep(1) until (JSON.parse(@proxy.status_for(:ascan))['status'] == '100')
      end
    end

    def shutdown
      @proxy.shutdown
    end

    def alerts
      JSON.pretty_generate(JSON.parse(@proxy.alerts.view))
    end

    def report(output)
      alerts = JSON.parse(@proxy.alerts.view)['alerts']
      html = "<html><body><table>"
      alerts.each_with_index do |alert, index|
        if index == 0
          html += "<tr>"
          alert.keys.each do |key|
            html += "<th scope=\"col\">#{key}</th>"
          end
          html += "</tr>"
        end
        html += "<tr>"
        alert.values.each do |value|
          html += "<td>#{value}</td>"
        end
        html += "</tr>"
      end

      html += "</table></body></html>"

      File.open(output, 'w') { |file| file.write(html) }
    end

  end

end
