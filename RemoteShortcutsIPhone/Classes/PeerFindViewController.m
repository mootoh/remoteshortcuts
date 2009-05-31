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

/*
- (void) loadView
{
}
*/

- (void) viewDidLoad
{
   [super viewDidLoad];
}

- (void) dealloc
{
   [super dealloc];
}

- (void) stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode
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
          unsigned int len = ((data_len - byteIndex >= 1024) ? 1024 : (data_len-byteIndex));
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
   if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
   }
   
   // Set up the cell...
   RemoteShortcutsIPhoneAppDelegate *app = (RemoteShortcutsIPhoneAppDelegate *)[[UIApplication sharedApplication] delegate];
   NSNetService *service = [app.services objectAtIndex:indexPath.row];
   cell.text = service.name;
	
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


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end