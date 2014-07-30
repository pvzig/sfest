//
//  TableViewController.m
//  Sfest
//
//  Created by Peter Zignego on 6/20/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.

#import "DailyTableViewController.h"
#import "Band.h"
#import "BandsDatabase.h"

@implementation DailyTableViewController

-(id)initWithStyle:(UITableViewStyle)style atStage:(NSString*)stage onDate:(NSString*)date withColor:(UIColor*)complimentaryColor {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.frame = CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-90);
    self.tableView.separatorColor = complimentaryColor;
    self.db = [[BandsDatabase alloc] init];
    self.data = [self.db bandsPlayingAtStage:stage onDate:date];
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    count = self.data.count;
    if (count == 0){
        count = 1;
    }
    return count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48.00;
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *bandLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 11, 220, 26)];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, 11, 80, 26)];
    
    bandLabel.font = [UIFont fontWithName:@"Futura" size:18];
    bandLabel.adjustsFontSizeToFitWidth = true;
    bandLabel.numberOfLines = 0;
    timeLabel.font = [UIFont fontWithName:@"Futura" size:18];
    timeLabel.textAlignment = NSTextAlignmentRight;
    
    [cell addSubview:bandLabel];
    [cell addSubview:timeLabel];
    if (self.data.count != 0){
        Band *band = [self.data objectAtIndex:indexPath.row];
        bandLabel.text = band.band;
        timeLabel.text = band.time;
    }
    else {
        bandLabel.text = @"No bands here tonight.";
        timeLabel.text = @"";
    }
    return cell;
}

-(void)dateChanged:(NSString*)date stage:(NSString*)stage {
    self.data = [NSArray new];
    self.data = [self.db bandsPlayingAtStage:stage onDate:date];
    [self.tableView reloadData];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end