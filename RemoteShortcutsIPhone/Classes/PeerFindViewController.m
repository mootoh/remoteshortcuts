//
//  PeerFindViewController.m
//  RemoteShortcutsIPhone
//
//  Created by mootoh on 5/31/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

#import "PeerFindViewController.h"
#import "RemoteShortcutsIPhoneAppDelegate.h"
#import "RemoteShortcutsIPhoneViewController.h"

@implementation PeerFindViewController

@synthesize table_view;

- (void) viewDidLoad
{
   [super viewDidLoad];
}

- (void) dealloc
{
   [super dealloc];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   RemoteShortcutsIPhoneAppDelegate *app = (RemoteShortcutsIPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
   return app.services.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return section == 0 ? @"Peers" : nil;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"PeerFindViewCell";
   
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil)
      cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
   
   // Set up the cell...
   RemoteShortcutsIPhoneAppDelegate *app = (RemoteShortcutsIPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
   NSNetService *service = [app.services objectAtIndex:indexPath.row];
   cell.textLabel.text = service.name;
	
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   RemoteShortcutsIPhoneAppDelegate *app = (RemoteShortcutsIPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
   NSNetService *service = [app.services objectAtIndex:indexPath.row];
   RemoteShortcutsIPhoneViewController *rsivc = [[RemoteShortcutsIPhoneViewController alloc] initWithNibName:@"RemoteShortcutsIPhoneViewController" bundle:nil];
   rsivc.service = service;
   [self.navigationController pushViewController:rsivc animated:YES];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];

   // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}

@end