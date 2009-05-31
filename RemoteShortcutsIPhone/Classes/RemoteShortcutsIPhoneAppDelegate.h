//
//  RemoteShortcutsIPhoneAppDelegate.h
//  RemoteShortcutsIPhone
//
//  Created by Motohiro Takayama on 5/29/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

@interface RemoteShortcutsIPhoneAppDelegate : NSObject <UIApplicationDelegate> {
   UIWindow *window;
   UINavigationController *navigationController;

   NSNetServiceBrowser *browser;
   NSMutableArray *services;   
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *services;
@end