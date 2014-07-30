//
//  MapPoint.m
//  Sfest
//
//  Created by Peter Zignego on 7/1/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.
//

#import "MapPoint.h"
#import <AddressBook/AddressBook.h>

@implementation MapPoint

@synthesize coordinate, title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)locationCoordinate title:(NSString *)titleString {
    coordinate = locationCoordinate;
    title = titleString;
    return self;
}

-(MKMapItem*)mapItem {
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : @""};
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end
