#
#  daemon.rb
#  RemoteShortcutsMac
#
#  Created by Motohiro Takayama on 5/28/09.
#  Copyright (c) 2009 deadbeaf.org. All rights reserved.
#
require "socket"

class Daemon < OSX::NSObject
   DAEMON_PORT  = 12345

   def init
      bundle = OSX::NSBundle::mainBundle;
      path = bundle.pathForResource_ofType("ShortcutHandler", "scpt")
      script_url = OSX::NSURL.alloc.initFileURLWithPath(path)
      @tc = OSX::TCallScript.alloc.initWithURLToCompiledScript(script_url)

      @net_service = OSX::NSNetService.alloc.initWithDomain_type_name_port('', '_wwdcpic._tcp', '', DAEMON_PORT)
      @net_service.setDelegate(self)
      @net_service.publish

      start_thread
   end
   

   def start_thread
      gs = TCPServer.open(DAEMON_PORT)
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

   def netServiceWillPublish(sender)
      puts 'netServiceWillPublish called'
   end
   
   def netService_didNotPublish(sender, errorDict)
      puts 'didNotPublish called'
      if errorDict[OSX::NSNetServicesErrorCode].to_i == OSX::NSNetServicesCollisionError
         puts 'A name collision occurred. A service is already running with that name someplace else.'
      else
         puts 'Some other unknown error occurred.'
      end
      
      @netService = nil
   end
   
   def netServiceDidStop(sender)
      puts 'netServiceDidStop called'
      @net_service = nil
   end

end # Daemon