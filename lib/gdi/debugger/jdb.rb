require 'gdi/debugger'

class Redcar::GDI::Debugger::JDB < Redcar::GDI::Debugger
  class << self
    def commandline
      "jdb -attach "
    end

    def backtrace
      "where"
    end

    def locals
      "locals"
    end

    def breakpoints
      "clear"
    end
  end
end
