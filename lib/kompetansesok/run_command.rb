module Kompetansesok
  class RunCommand

    #kaster exception hvis kommandoen feiler, returnerer utskriften fra funksjonen
    def run_command(command)
      tekst = capture_output do
        unless system(command)
          raise "Kunne ikke kjøre '#{command}'; feil:#{$?}"
        end
      end

      if tekst =~ /ERROR/
        raise "Kunne ikke kjøre '#{command}'; feil:#{tekst}"
      end

      tekst
    end

    #runs the given block, and returns the block output to stdout
    def capture_output(&proc)
      log = StringIO.new
      old_stdout = $stdout
      $stdout = log
      proc.call
      log.read
    rescue Exception => e
      e.message << "Historie: #{log.read}" if log.size != 0
      raise e
    ensure
      $stdout = old_stdout
    end

  end
end