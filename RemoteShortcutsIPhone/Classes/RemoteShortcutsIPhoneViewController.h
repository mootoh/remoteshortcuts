//
//  RemoteShortcutsIPhoneViewController.h
//  RemoteShortcutsIPhone
//
//  Created by Motohiro Takayama on 5/29/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

@interface RemoteShortcutsIPhoneViewController : UIViewController
{
   NSInputStream  *istream;
   NSOutputStream *ostream;
   NSNetServiceBrowser *browser;
   NSMutableArray *services;
}

- (IBAction) shortcutCopy;
- (IBAction) shortcutPaste;
- (IBAction) setupPeers;

@end