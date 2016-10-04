//
//  TCNumbersTableViewController.m
//  TCTimePicker
//
//  Created by Tomas Cordoba on 26.08.16.
//  Copyright © 2016 Tomas Cordoba. All rights reserved.
//

#import "TCNumbersTableViewController.h"
#import "TCNumberViewCell.h"

@interface TCNumbersTableViewController ()

@end

@implementation TCNumbersTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSDate *date = [[NSDate alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate: date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    if([self.digits count] == 25){ //Is the hours table
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow: hour+1 inSection:30];
        [[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    if([self.digits count] == 60){ //Is the hours table
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow: minute+1 inSection:30];
        [[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.digits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TCNumberViewCell";
    
    TCNumberViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *body = [NSString stringWithFormat:@"%02d",  (int)indexPath.row];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: body];    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, 2)];
    
    cell.numberLabel.attributedText = attributedString;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.numberLabel.numberOfLines = 1;
    cell.numberLabel.minimumScaleFactor = 0.5;
    cell.numberLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}



- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // Determine which table cell the scrolling will stop on.
    CGFloat cellHeight = 140.0f;
    NSInteger cellIndex = floor(targetContentOffset->y / cellHeight);
    
    // Round to the next cell if the scrolling will stop over halfway to the next cell.
    if (targetContentOffset->y - floor(cellIndex * cellHeight) > cellHeight/2){
        cellIndex++;
    }
    
    // Calculate selected value
    int value = (int)cellIndex +1;
    
    NSIndexPath * path = [self.tableView indexPathForCell:[[self.tableView visibleCells] objectAtIndex:1]];
    NSUInteger sectionNumber = path.section;
    
    if(value >= [self.digits count]){
        
        value = value - ((int)[self.digits count] * (int)sectionNumber);
        if(value == [self.digits count]){
            value = 0;
        }
    }
    
    // Save value selected
    if([self.digits count] == 25){ //Is the hours table
        [[NSUserDefaults standardUserDefaults] setInteger:value forKey:@"hourSelected"];
    }
    if([self.digits count] == 60){ //Is the hours table
        [[NSUserDefaults standardUserDefaults] setInteger:value forKey:@"minuteSelected"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Adjust stopping point to exact beginning of cell.
    targetContentOffset->y = cellIndex * cellHeight;
    
    NSLog(@"%ld:%ld", [[NSUserDefaults standardUserDefaults] integerForKey:@"hourSelected"], (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"minuteSelected"]);
}




@end