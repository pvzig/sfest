//
//  Bands.h
//  Sfest
//
//  Created by Peter Zignego on 6/20/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.

@interface Band : NSObject

@property (nonatomic, assign) int uniqueId;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *stage;
@property (nonatomic, copy) NSString *band;

-(id)initWithUniqueId:(int)uniqueId date:(NSString *)date time:(NSString *)time stage:(NSString *)stage band:(NSString *)band;

@end
