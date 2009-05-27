#
#  daemon.rb
#  RemoteShortcutsMac
#
#  Created by Motohiro Takayama on 5/28/09.
#  Copyright (c) 2009 deadbeaf.org. All rights reserved.
#
require "socket"

class Daemon
   PORT = 12345

   def initialize
      Thread.new { start_thread }
   end

   def start_thread
      gs = TCPServer.open(PORT)
      addr = gs.addr
      addr.shift
      printf("server is on %s\n", addr.join(":"))

      while true
         Thread.start(gs.accept) do |s|       # save to dynamic variable
            print(s, " is accepted¥n")
            while s.gets
               case $_
                  when 'C'
                     copy
                  when 'V'
                     paste
                  else
                     do_nothing
               end
               s.write($_)
            end
            print(s, " is gone¥n")
            s.close
         end
      end
   end
end # Daemon
