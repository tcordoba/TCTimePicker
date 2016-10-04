//
//  TCViewController.m
//  TCTimePicker
//
//  Created by Tomas Cordoba on 08/26/2016.
//  Copyright (c) 2016 Tomas Cordoba. All rights reserved.
//

#import "TCViewController.h"
#import "TCNumbersTableViewController.h"

@interface TCViewController ()
    
@end

@implementation TCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set actual hour and minutes
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate: [[NSDate alloc] init]];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    self.actualHour   = (int)hour;
    self.actualMinute = (int)minute;
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.actualHour forKey:@"hourSelected"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.actualMinute forKey:@"minuteSelected"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"hoursSegue"]) {
        _digitsHours = [[NSMutableArray alloc] initWithCapacity:25];
        for (int i=0; i<=24; i++) {
            NSNumber* xWrapped = [NSNumber numberWithInt:i];
            [_digitsHours addObject:xWrapped];
        }
        
        TCNumbersTableViewController *vc = [segue destinationViewController];
        vc.digits = _digitsHours;
        self.hoursView = vc;
    }
    
    if ([[segue identifier] isEqualToString:@"minutesSegue"]) {
        _digitsMinutes = [[NSMutableArray alloc] initWithCapacity:60];
        for (int i=0; i<=59; i++) {
            NSNumber* xWrapped = [NSNumber numberWithInt:i];
            [_digitsMinutes addObject:xWrapped];
        }
        
        TCNumbersTableViewController *vc = [segue destinationViewController];
        vc.digits = _digitsMinutes;
        self.minutesView = vc;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)minutesUpAction:(id)sender {
    NSLog(@"%s", "Minute Up gesture");
}

- (IBAction)minutesDownAction:(id)sender {
    NSLog(@"%s", "Minute Down gesture");
}

- (IBAction)hoursUpAction:(id)sender {
    NSLog(@"%s", "Hours Up gesture");
}

- (IBAction)hoursDownAction:(id)sender {
    NSLog(@"%s", "Hours Down gesture");
}
@end
