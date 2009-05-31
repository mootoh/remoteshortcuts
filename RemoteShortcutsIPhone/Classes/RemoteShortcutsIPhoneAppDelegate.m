//
//  RemoteShortcutsIPhoneAppDelegate.m
//  RemoteShortcutsIPhone
//
//  Created by Motohiro Takayama on 5/29/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "RemoteShortcutsIPhoneAppDelegate.h"
#import "RemoteShortcutsIPhoneViewController.h"
#import "PeerFindViewController.h"

@implementation RemoteShortcutsIPhoneAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize services;

- (void) findPeers
{
   browser = [[NSNetServiceBrowser alloc] init];
   services = [[NSMutableArray array] retain];
   [browser setDelegate:self];
   
   [browser searchForServicesOfType:@"_wwdcpic._tcp." inDomain:@""];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
   [self findPeers];
   // Override point for customization after app launch    
   [window addSubview:navigationController.view];
   [window makeKeyAndVisible];
}

- (void) dealloc
{
   [navigationController release];
   [window release];
   [super dealloc];
}

#pragma mark netServiceBrowser

- (void) updatePeers
{
   if ([navigationController.topViewController isKindOfClass:[PeerFindViewController class]]) {
      PeerFindViewController *pfvc = (PeerFindViewController *)navigationController.topViewController;
      [pfvc.table_view reloadData];
   }
}   

// This object is the delegate of its NSNetServiceBrowser object. We're only interested in services-related methods, so that's what we'll call.
- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
   aNetService.delegate = self;
   [services addObject:aNetService];
   [aNetService resolveWithTimeout:5.0];
 
   [self updatePeers];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
   [services removeObject:aNetService];
   aNetService.delegate = nil;

   if ([navigationController.topViewController isKindOfClass:[RemoteShortcutsIPhoneViewController class]]) {
      RemoteShortcutsIPhoneViewController *rsipvc = (RemoteShortcutsIPhoneViewController *)navigationController.topViewController;
      if ([aNetService isEqual:rsipvc.service]) {
         [navigationController popViewControllerAnimated:YES];
      }
   }
   [self updatePeers];
}

@end