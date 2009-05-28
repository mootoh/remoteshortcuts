//
//  RemoteShortcutsIPhoneViewController.m
//  RemoteShortcutsIPhone
//
//  Created by Motohiro Takayama on 5/29/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "RemoteShortcutsIPhoneViewController.h"

@implementation RemoteShortcutsIPhoneViewController

- (void) setupStreams
{
   NSLog(@"current host = %@", [[NSHost currentHost] address]);
   
   NSHost *host = [NSHost hostWithAddress:@"192.168.1.103"];
   // iStream and oStream are instance variables
   [NSStream getStreamsToHost:host port:12345 inputStream:&istream
                 outputStream:&ostream];
   [istream retain];
   [ostream retain];
   [istream setDelegate:self];
   [ostream setDelegate:self];
   [istream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSDefaultRunLoopMode];
   [ostream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSDefaultRunLoopMode];
   [istream open];
   [ostream open];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
   [super viewDidLoad];
   [self setupStreams];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction) shortcutCopy
{
   uint8_t buf[] = "C\n";
   NSInteger wrote = [ostream write:buf maxLength:2];
   NSLog(@"copy wrote = %d", wrote);
}

- (IBAction) shortcutPaste
{
   uint8_t buf[] = "V\n";
   NSInteger wrote = [ostream write:buf maxLength:2];
   NSLog(@"paste wrote = %d", wrote);
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode
{
   switch(eventCode) {
      case NSStreamEventOpenCompleted:
         NSLog(@"open completed for stream %p", stream);
         break;
      case NSStreamEventHasSpaceAvailable:
      {
         /*
         uint8_t *readBytes = (uint8_t *)[_data mutableBytes];
         readBytes += byteIndex; // instance variable to move pointer
         int data_len = [_data length];
         unsigned int len = ((data_len - byteIndex >= 1024) ?
                             1024 : (data_len-byteIndex));
         uint8_t buf[len];
         (void)memcpy(buf, readBytes, len);
         len = [stream write:(const uint8_t *)buf maxLength:len];
         byteIndex += len;
         break;
         */
      }
         // continued ...
   }
}

@end