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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.digits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TCNumberViewCell";
    
    TCNumberViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(_addZeros)
        cell.numberLabel.text = [NSString stringWithFormat:@"%02d", [[self.digits objectAtIndex: indexPath.row] intValue] ];
    else
        cell.numberLabel.text = [NSString stringWithFormat:@"%d", [[self.digits objectAtIndex: indexPath.row] intValue]];
    
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
    
    // Adjust stopping point to exact beginning of cell.
    targetContentOffset->y = cellIndex * cellHeight;

}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    CGFloat actualPosition = scrollView_.contentOffset.y;
    CGFloat contentHeight = scrollView_.contentSize.height - (700);
    if (actualPosition >= contentHeight) {
        [self.digits addObjectsFromArray:self.digits];
        [self.tableView reloadData];
    }
}
@end