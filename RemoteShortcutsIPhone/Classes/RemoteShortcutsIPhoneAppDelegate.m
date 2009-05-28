//
//  RemoteShortcutsIPhoneAppDelegate.m
//  RemoteShortcutsIPhone
//
//  Created by Motohiro Takayama on 5/29/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "RemoteShortcutsIPhoneAppDelegate.h"
#import "RemoteShortcutsIPhoneViewController.h"

@implementation RemoteShortcutsIPhoneAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
   // Override point for customization after app launch    
   [window addSubview:viewController.view];
   [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end