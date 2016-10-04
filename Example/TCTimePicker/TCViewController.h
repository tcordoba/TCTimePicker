//
//  TCViewController.h
//  TCTimePicker
//
//  Created by Tomas Cordoba on 08/26/2016.
//  Copyright (c) 2016 Tomas Cordoba. All rights reserved.
//

#import "TCNumbersTableViewController.h"
@import UIKit;

@interface TCViewController : UIViewController

@property (nonatomic) int actualMinute;
@property (nonatomic) int actualHour;

@property(nonatomic,retain)NSMutableArray *digitsHours;
@property(nonatomic,retain)NSMutableArray *digitsMinutes;

@property (weak, nonatomic) TCNumbersTableViewController *hoursView;
@property (weak, nonatomic) TCNumbersTableViewController *minutesView;

- (IBAction)minutesUpAction:(id)sender;
- (IBAction)minutesDownAction:(id)sender;
- (IBAction)hoursUpAction:(id)sender;
- (IBAction)hoursDownAction:(id)sender;

@end
