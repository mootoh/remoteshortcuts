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
@synthesize viewController;
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
   [window addSubview:viewController.view];
   [window makeKeyAndVisible];
}

- (void) dealloc
{
   [viewController release];
   [window release];
   [super dealloc];
}

#pragma mark netServiceBrowser

// This object is the delegate of its NSNetServiceBrowser object. We're only interested in services-related methods, so that's what we'll call.
- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
   NSLog(@"didFind");
   aNetService.delegate = self;
   [services addObject:aNetService];
   [aNetService resolveWithTimeout:5.0];
   
   PeerFindViewController *pfvc = [[PeerFindViewController alloc] initWithNibName:@"PeerFindView" bundle:nil];
   [window addSubview:pfvc.view];
   //[pfvc release];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
   NSLog(@"didRemove");
   [services removeObject:aNetService];
   aNetService.delegate = nil;
}

@end