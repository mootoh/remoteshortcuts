//
//  RemoteShortcutsIPhoneAppDelegate.h
//  RemoteShortcutsIPhone
//
//  Created by Motohiro Takayama on 5/29/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

@class RemoteShortcutsIPhoneViewController;

@interface RemoteShortcutsIPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RemoteShortcutsIPhoneViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RemoteShortcutsIPhoneViewController *viewController;

@end

