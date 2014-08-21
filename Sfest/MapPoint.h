//
//  MapPoint.h
//  Sfest
//
//  Created by Peter Zignego on 7/1/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapPoint : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)locationCoordinate title:(NSString *)titleString;
-(MKMapItem*)mapItem;

@end
