//
//  MapView.m
//  Sfest
//
//  Created by Peter Zignego on 7/25/14.
//  Copyright (c) 2014 CoffeCode. All rights reserved.
//

#import "MapView.h"

@implementation MapView

-(instancetype)initWithFrame:(CGRect)frame stage:(NSString*)stage {
    self = [super initWithFrame:frame];
    if (self) {
        self.stageName = stage;
        [self showAddress];
        [self userLocationManager];
    }
    return self;
}

-(void)showAddress {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.0025;
    span.longitudeDelta=0.0025;
    
    CLLocationCoordinate2D location;
    
    if ([self.stageName isEqual: @"BMO Harris Pavilion"]){
        location.latitude = 43.02871;
        location.longitude = -87.89672;
    }
    if ([self.stageName isEqual: @"Briggs & Stratton Big Backyard"]){
        location.latitude = 43.030026;
        location.longitude = -87.899661;
    }
    if ([self.stageName isEqual: @"Harley-Davidson Roadhouse"]){
        location.latitude = 43.03103;
        location.longitude = -87.899731;
    }
    if ([self.stageName isEqual: @"Johnson Controls World Sound Stage"]){
        location.latitude = 43.03344;
        location.longitude = -87.898385;
    }
    if ([self.stageName isEqual: @"Marcus Amphitheater"]){
        location.latitude = 43.027339;
        location.longitude = -87.897701;
    }
    if ([self.stageName isEqual: @"Miller Lite Oasis"]){
        location.latitude = 43.03209;
        location.longitude = -87.899892;
    }
    if ([self.stageName isEqual: @"U.S. Cellular Connection Stage"]){
        location.latitude = 43.034468;
        location.longitude = -87.898444;
    }
    if ([self.stageName isEqual: @"Uline Warehouse"]){
        location.latitude = 43.035354;
        location.longitude = -87.898178;
    }
    
    region.span=span;
    region.center=location;
    
    [self setRegion:region animated:TRUE];
    [self regionThatFits:region];
    
    MapPoint *mp = [[MapPoint alloc] initWithCoordinate:location title:self.stageName];
    [self addAnnotation:mp];
    [self selectAnnotation:mp animated:YES];
}

-(void)userLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.showsUserLocation = true;
}

-(MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    NSString *annotationIdentifier = @"PinViewAnnotation";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[self dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if (!pinView){
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        pinView.pinColor = MKPinAnnotationColorGreen;
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
    }
    else{
        pinView.annotation = annotation;
    }
    return pinView;
}

@end
