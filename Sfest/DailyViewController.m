//
//  DailyViewController.m
//  Sfest
//
//  Created by Peter Zignego on 7/25/14.
//  Copyright (c) 2014 CoffeCode. All rights reserved.
//

#import "DailyViewController.h"
#import "DailyTableViewController.h"

@interface DailyViewController ()

@property DailyTableViewController *dtvc;

@end

@implementation DailyViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.globalDate = [self dateTest:[NSDate date]];
    [self gestureRecognizers];
    [self setupView];
}

-(void)viewDidAppear:(BOOL)animated {
    UIView *animateView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-45)];
    animateView.backgroundColor = self.stageColor;
    [self.view addSubview:animateView];
    [UIView animateWithDuration:0.5 delay:0.00 usingSpringWithDamping:0.5 initialSpringVelocity:1.00 options:UIViewAnimationOptionCurveEaseOut animations:^{
                         animateView.frame = CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height, [[UIScreen mainScreen]bounds].size.width, animateView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [animateView removeFromSuperview];
                     }];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)setupView {
    //Stage
    self.stageView.backgroundColor = self.stageColor;
    self.stageNameLabel.text = self.stageName;
    if ([self.stageName isEqual: @"Johnson Controls World Sound Stage"]) {
        self.stageNameLabel.font = [UIFont fontWithName:@"Futura" size:16];
    }
    //Date
    self.dayOfTheWeekLabel.text = [[self convertDateToStrings:self.globalDate] objectForKey:@"dayString"];
    self.dateLabel.text = [[self convertDateToStrings:self.globalDate] objectForKey:@"longString"];
    self.dateView.backgroundColor = self.complimentaryColor;
    
    //Tableview Subview
    self.dtvc = [[DailyTableViewController alloc] initWithStyle:UITableViewStylePlain atStage:self.stageName onDate:[[self convertDateToStrings:self.globalDate] objectForKey:@"queryString"] withColor:self.complimentaryColor];
    [self addChildViewController:self.dtvc];
    [self.view addSubview:self.dtvc.view];
    [self.dtvc didMoveToParentViewController:self];
    [self.view bringSubviewToFront:self.closeButton];
}


-(void)gestureRecognizers {
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchToClose:)];
    UISwipeGestureRecognizer *forward = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeForward:)];
    forward.direction = UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer *back = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    back.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:pinch];
    [self.view addGestureRecognizer:forward];
    [self.view addGestureRecognizer:back];
}

-(NSDate*)dateTest:(NSDate*)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.calendar = [NSCalendar currentCalendar];
    dateComponents.year = 2013;
    dateComponents.month = 6;
    dateComponents.day = 26;
    NSDate *startDate = dateComponents.date;
    dateComponents.year = 2013;
    dateComponents.month = 7;
    dateComponents.day = 7;
    NSDate *endDate = dateComponents.date;
    NSComparisonResult startDateComparisonResult = [date compare:startDate];
    NSComparisonResult endDateComparisonResult = [date compare:endDate];
    if (startDateComparisonResult == NSOrderedAscending) {
        return startDate;
    }
    else if (endDateComparisonResult == NSOrderedDescending) {
        return endDate;
    }
    else {
        return date;
    }
}

-(IBAction)nextDateButton:(UIButton *)sender {
    self.globalDate = [self dateTest:[self.globalDate dateByAddingTimeInterval:24*60*60]];
    self.dayOfTheWeekLabel.text = [[self convertDateToStrings:self.globalDate] objectForKey:@"dayString"];
    self.dateLabel.text = [[self convertDateToStrings:self.globalDate] objectForKey:@"longString"];
    self.delegate = self.dtvc;
    [self.delegate dateChanged:[[self convertDateToStrings:self.globalDate] objectForKey:@"queryString"]  stage:self.stageName];
}

-(IBAction)previousDateButton:(UIButton *)sender {
    self.globalDate = [self dateTest:[self.globalDate dateByAddingTimeInterval:-24*60*60]];
    self.dayOfTheWeekLabel.text = [[self convertDateToStrings:self.globalDate] objectForKey:@"dayString"];
    self.dateLabel.text = [[self convertDateToStrings:self.globalDate] objectForKey:@"longString"];
    self.delegate = self.dtvc;
    [self.delegate dateChanged:[[self convertDateToStrings:self.globalDate] objectForKey:@"queryString"]  stage:self.stageName];
}

-(NSDictionary*)convertDateToStrings:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"M/d/yyyy";
    NSString *queryString = [dateFormatter stringFromDate:date];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    NSString *longString = [dateFormatter stringFromDate:date];
    dateFormatter.dateFormat = @"EEEE";
    NSString *dayString = [dateFormatter stringFromDate:date];
    return @{@"queryString": queryString, @"longString": longString, @"dayString": dayString};
}


//Gestures
-(void)swipeForward:(UISwipeGestureRecognizer *)sender {
    [self previousDateButton:(UIButton *)sender];
}

-(void)swipeBack:(UISwipeGestureRecognizer *)sender {
    [self nextDateButton:(UIButton *)sender];
}

- (IBAction)close:(UIButton *)sender {
    if (self.mapView.frame.origin.y == 45) {
        [self hideMapView];
    }
    else {
        [self pinchToClose:(UIPinchGestureRecognizer*)sender];
    }
}

-(void)pinchToClose:(UIPinchGestureRecognizer *)sender {
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    [self.view addSubview:background];
    [background setImage:self.backgroundImage];
    UIView *animateview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    animateview.backgroundColor = self.stageView.backgroundColor;
    [self.view addSubview:animateview];
    [UIView animateWithDuration:.5
                     animations:^{
                         animateview.frame = self.returnRectangle;
                         animateview.alpha = .5;
                     }
                     completion:^(BOOL finished){
                         [animateview removeFromSuperview];
                         [background removeFromSuperview];
                         StageCollectionViewController *scvc = [self.navigationController.viewControllers objectAtIndex:0];
                         scvc.savedScrollPosition = self.savedScrollPosition;
                         [self.navigationController popToRootViewControllerAnimated:NO];
                     }];
}

-(IBAction)mapButton:(UIButton *)sender {
    if (self.mapView.frame.origin.y == 45) {
        [self hideMapView];
    }
    else {
        [self showMapView];
    }
}

-(void)showMapView {
    self.mapView = [[MapView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-45) stage:self.stageName];
    [self.view addSubview:self.mapView];
    [self.view bringSubviewToFront:self.closeButton];
    [UIView animateWithDuration:0.5 delay:0.00 usingSpringWithDamping:0.5 initialSpringVelocity:1.00 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.mapView.frame = CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-45);
    }
    completion:^(BOOL finished){
    }];
}

-(void)hideMapView {
    [UIView animateWithDuration:0.5 delay:0.00 usingSpringWithDamping:0.5 initialSpringVelocity:1.00 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.mapView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-45);
    }
    completion:^(BOOL finished){
        [self.mapView removeFromSuperview];
        self.mapView = nil;
    }];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
