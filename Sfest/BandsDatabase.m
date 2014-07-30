//
//  BandsDatabase.m
//  Sfest
//
//  Created by Peter Zignego on 6/20/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.

#import "BandsDatabase.h"
#import "Band.h"

@implementation BandsDatabase

static BandsDatabase *_database;

+(BandsDatabase*)database {
    if (_database == nil) {
        _database = [[BandsDatabase alloc] init];
    }
    return _database;
}

-(id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"sfdb"
                                                             ofType:@"sqlite3"];
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

-(NSArray *)bandsPlayingAtStage:(NSString *)stage onDate:(NSString*)date {
    NSMutableArray *results = [NSMutableArray new];
    NSString *queryString = @"SELECT UID, DATE, TIME, STAGE, BAND FROM sfinfo WHERE DATE='RDATE' AND STAGE='RSTAGE'";
    queryString = [queryString stringByReplacingOccurrencesOfString:@"RDATE" withString:date];
    queryString = [queryString stringByReplacingOccurrencesOfString:@"RSTAGE" withString:stage];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [queryString UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *dateChars = (char *) sqlite3_column_text(statement, 1);
            char *timeChars = (char *) sqlite3_column_text(statement, 2);
            char *stageChars = (char *) sqlite3_column_text(statement, 3);
            char *bandChars = (char *) sqlite3_column_text(statement, 4);
            NSString *date = [[NSString alloc] initWithUTF8String:dateChars];
            NSString *time = [[NSString alloc] initWithUTF8String:timeChars];
            NSString *stage = [[NSString alloc] initWithUTF8String:stageChars];
            NSString *band = [[NSString alloc] initWithUTF8String:bandChars];
            Band *info = [[Band alloc] initWithUniqueId:uniqueId date:date time:time stage:stage band:band];
            [results addObject:info];
        }
        sqlite3_finalize(statement);
    }
    return results;
}

@end
