//
//  RemoteShortcutsIPhoneViewController.m
//  RemoteShortcutsIPhone
//
//  Created by Motohiro Takayama on 5/29/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "RemoteShortcutsIPhoneViewController.h"

@implementation RemoteShortcutsIPhoneViewController
@synthesize service;

- (void) setupStreams
{
   [service getInputStream:&istream outputStream:&ostream];
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad
{
   [super viewDidLoad];
   [self setupStreams];
}

- (void) viewWillDisappear:(BOOL)animated
{
   [super viewWillDisappear:animated];
   [istream close];
   [ostream close];
   [service stop];
}

- (void)dealloc
{
   if (istream) [istream release];
   if (ostream) [ostream release];
   [super dealloc];
}

- (IBAction) shortcutCopy
{
   uint8_t buf[] = "C\n";
   NSInteger wrote = [ostream write:buf maxLength:2];
   if (wrote != 2)
      NSLog(@"something wrong is happened at copy");
}

- (IBAction) shortcutPaste
{
   uint8_t buf[] = "V\n";
   NSInteger wrote = [ostream write:buf maxLength:2];
   if (wrote != 2)
      NSLog(@"something wrong is happened at paste");
}

@end