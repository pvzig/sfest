//
//  DailyViewController.h
//  Sfest
//
//  Created by Peter Zignego on 7/25/14.
//  Copyright (c) 2014 CoffeCode. All rights reserved.

#import "MapView.h"
#import "StageCollectionViewController.h"

@protocol DateChangedDelegate <NSObject>

-(void)dateChanged:(NSString*)date stage:(NSString*)stage;

@end

@interface DailyViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UIView *stageView;
@property (nonatomic, strong) IBOutlet UIView *dateView;
@property (nonatomic, strong) IBOutlet UILabel *stageNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dayOfTheWeekLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UIButton *closeButton;

@property (nonatomic, strong) MapView *mapView;
@property (nonatomic, strong) NSDate *globalDate;
@property (nonatomic, strong) NSString *stageName;
@property (nonatomic, strong) UIColor *stageColor;
@property (nonatomic, strong) UIColor *complimentaryColor;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) NSIndexPath *selectedIndex;
@property (nonatomic) CGPoint savedScrollPosition;
@property (nonatomic) CGRect returnRectangle;

@property id <DateChangedDelegate> delegate;

@end
