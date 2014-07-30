//
//  Bands.m
//  Sfest
//
//  Created by Peter Zignego on 6/20/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.

#import "Band.h"

@implementation Band

-(id)initWithUniqueId:(int)uniqueId date:(NSString *)date time:(NSString *)time stage:(NSString *)stage band:(NSString *)band {
    if ((self = [super init])) {
        self.uniqueId = uniqueId;
        self.date = date;
        self.time = time;
        self.stage = stage;
        self.band = band;
    }
    return self;
}

@end
