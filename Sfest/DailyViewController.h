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

@property (strong, nonatomic) IBOutlet UIView *stageView;
@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) IBOutlet UILabel *stageNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayOfTheWeekLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@property MapView *mapView;
@property NSDate *globalDate;
@property NSString *stageName;
@property UIColor *stageColor;
@property UIColor *complimentaryColor;
@property UIImage *backgroundImage;
@property NSIndexPath *selectedIndex;
@property CGPoint savedScrollPosition;
@property CGRect returnRectangle;

@property id <DateChangedDelegate> delegate;

@end
