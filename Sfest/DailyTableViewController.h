//
//  TableViewController.h
//  Sfest
//
//  Created by Peter Zignego on 6/20/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.

#import "DailyViewController.h"
#import "BandsDatabase.h"

@interface DailyTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, DateChangedDelegate>

@property NSArray *data;
@property BandsDatabase *db;

-(id)initWithStyle:(UITableViewStyle)style atStage:(NSString*)stage onDate:(NSString*)date withColor:(UIColor*)complimentaryColor;

@end
