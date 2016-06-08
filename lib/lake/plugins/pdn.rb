require "net/http"
require "uri"
require 'eventmachine'
require 'em-http'
require 'ruby-progressbar'
module Lake
  module PDn
    Status = Struct.new(:total_size,:average_speed,:current_speed,:downloaded_size)

    def download(uri,out,bsize=512,&cb)
      uri = URI(uri) unless uri.kind_of? URI
      start = Time.now.to_f
      last = start
      stat = Status.new(0,0,0,0)
      File.open(out,"w") do |ofile|
        EventMachine.run{
          http = EventMachine::HttpRequest.new(uri.to_s).get
          http.headers{
            |hash|
            stat.total_size = hash["Content-Length"].to_i
          }
          http.stream{
            |c|
            curr = Time.now.to_f
            stat.downloaded_size += c.length
            stat.average_speed = stat.downloaded_size/(curr-start)
            stat.current_speed = c.length/(curr-last)
            last = curr
            yield stat if block_given?
            ofile.write(c)
          }
          http.callback {
            EventMachine.stop
          }
        }
      end
    end

    def pretty_dn(uri,out,bsize=512)
      #last_line_size = 0
      $stdout.puts "IN : #{uri}"
      $stdout.puts "OUT : #{out}"
      pb = ProgressBar.create
      as = 0
      download uri,out,bsize do
        |stat|
        percentage = stat.downloaded_size*100/stat.total_size
        pb.progress = percentage
        pb.title = "#{stat.downloaded_size}/#{stat.total_size} @ #{stat.current_speed.round}"
        as = stat.average_speed
      end
      pb.finish
      $stdout.puts "Average speed : #{as.round} bytes/sec"
    end
    module_function :download,:pretty_dn,:size
  end
end
