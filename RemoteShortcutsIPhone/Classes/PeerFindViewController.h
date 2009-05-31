//
//  PeerFindViewController.h
//  RemoteShortcutsIPhone
//
//  Created by mootoh on 5/31/09.
//  Copyright 2009 deadbeaf.org. All rights reserved.
//

@interface PeerFindViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
   NSInputStream  *istream;
   NSOutputStream *ostream;

   IBOutlet UILabel *messageLabel;
   IBOutlet UITableView *table_view;
}

@property (nonatomic, retain) IBOutlet UITableView *table_view;
@end