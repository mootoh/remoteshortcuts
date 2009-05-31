//
//  RemoteShortcutsIPhoneViewController.m
//  RemoteShortcutsIPhone
//
//  Created by Motohiro Takayama on 5/29/09.
//  Copyright deadbeaf.org 2009. All rights reserved.
//

#import "RemoteShortcutsIPhoneViewController.h"

@implementation RemoteShortcutsIPhoneViewController
   
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
- (void) viewDidLoad
{
   [super viewDidLoad];
}

- (void)dealloc
{
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

@end