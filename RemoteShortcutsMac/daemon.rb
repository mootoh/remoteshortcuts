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
      bundle = OSX::NSBundle::mainBundle;
      path = bundle.pathForResource_ofType("ShortcutHandler", "scpt")
      script_url = OSX::NSURL.alloc.initFileURLWithPath(path)
      @tc = OSX::TCallScript.alloc.initWithURLToCompiledScript(script_url)

      Thread.new { start_thread }
   end

   def start_thread
      gs = TCPServer.open(PORT)
      addr = gs.addr
      addr.shift
      printf("server is on %s\n", addr.join(":"))

      while true
         Thread.start(gs.accept) do |s|       # save to dynamic variable
            print(s, " is accepted\n")
            while msg = s.gets
               puts "got: " + msg + "---" + msg.size.to_s
               case msg
                  when /^C/
                     copy
                  when /^V/
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

   def copy
      @tc.callHandler_withParameters("ShortcutCopy", nil)
   end

   def paste
      @tc.callHandler_withParameters("ShortcutPaste", nil)
   end

   def do_nothing
      puts 'do_nothing'
   end
end # Daemon
