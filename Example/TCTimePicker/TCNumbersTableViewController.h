//
//  TCNumbersTableViewController.h
//  TCTimePicker
//
//  Created by Tomas Cordoba on 26.08.16.
//  Copyright © 2016 Tomas Cordoba. All rights reserved.
//

@import UIKit;

@interface TCNumbersTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,retain)NSMutableArray *digits;
@property (nonatomic, assign) int _currentItem;
@end