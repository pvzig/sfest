//
//  MapView.h
//  Sfest
//
//  Created by Peter Zignego on 7/25/14.
//  Copyright (c) 2014 CoffeCode. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapPoint.h"

@interface MapView : MKMapView <CLLocationManagerDelegate>

@property NSString *stageName;
@property CLLocationManager *locationManager;

-(instancetype)initWithFrame:(CGRect)frame stage:(NSString*)stage;

@end
