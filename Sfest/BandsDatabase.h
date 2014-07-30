//
//  BandsDatabase.h
//  Sfest
//
//  Created by Peter Zignego on 6/20/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.
//

#import <sqlite3.h>

@interface BandsDatabase : NSObject
{
    sqlite3 *_database;
}

+(BandsDatabase *)database;
-(NSArray *)bandsPlayingAtStage:(NSString *)stage onDate:(NSString*)date;

@end
