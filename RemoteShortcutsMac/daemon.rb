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
   
   ib_outlet :menus

   def quit(sender)
      OSX::NSApplication.sharedApplication.terminate nil
   end

   def toggle(sender)
      if @is_working
         @menu.setImage icon_images[1]
         @menu.setToolTip 'RemoteShortcuts is OFF'
         sender.setTitle 'ON'
      else
         @menu.setImage icon_images[0]
         @menu.setToolTip 'RemoteShortcuts is ON'
         sender.setTitle 'OFF'
      end
      @is_working = ! @is_working;
   end

   ib_action :quit
   ib_action :toggle

   def icon_images
      unless @s_icon_images
         bundle = OSX::NSBundle::mainBundle;
         
         paths = [
            bundle.pathForResource_ofType("activated", "png"),
            bundle.pathForResource_ofType("deactivated", "png")]
         @s_icon_images = paths.collect do |path|
            OSX::NSImage.alloc.initByReferencingFile(path)
         end
      end
      return @s_icon_images
   end

   def applicationDidFinishLaunching(notification)
      @is_working = true

      bar = OSX::NSStatusBar.systemStatusBar
      @menu = bar.statusItemWithLength(24).retain
      @menu.setImage(icon_images[0])
      @menu.setToolTip('Hello!')
      @menu.setHighlightMode true
      @menu.setMenu @menus

      bundle = OSX::NSBundle::mainBundle;
      path = bundle.pathForResource_ofType("ShortcutHandler", "scpt")
      script_url = OSX::NSURL.alloc.initFileURLWithPath(path)
      @tc = OSX::TCallScript.alloc.initWithURLToCompiledScript(script_url)

      @net_service = OSX::NSNetService.alloc.initWithDomain_type_name_port('', '_wwdcpic._tcp', '', DAEMON_PORT)
      @net_service.setDelegate(self)
      @net_service.publish

      Thread.new { start_daemon_thread }
   end
   
   def start_daemon_thread
      gs = TCPServer.open(DAEMON_PORT)
      addr = gs.addr
      addr.shift

      while true
         Thread.start(gs.accept) do |s|       # save to dynamic variable
            while msg = s.gets
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
   end

   def netServiceWillPublish(sender)
   end
   
   def netService_didNotPublish(sender, errorDict)
      if errorDict[OSX::NSNetServicesErrorCode].to_i == OSX::NSNetServicesCollisionError
         puts 'A name collision occurred. A service is already running with that name someplace else.'
      else
         puts 'Some other unknown error occurred.'
      end
      
      @netService = nil
   end
   
   def netServiceDidStop(sender)
      @net_service = nil
   end
end # Daemon