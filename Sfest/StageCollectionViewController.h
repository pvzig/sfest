//
//  StageCollectionViewController.h
//  Sfest
//
//  Created by Peter Zignego on 6/19/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.

@interface StageCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSArray *stages;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) CGPoint savedScrollPosition;

@end
