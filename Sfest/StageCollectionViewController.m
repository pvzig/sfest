//
//  StageCollectionViewController.m
//  Sfest
//
//  Created by Peter Zignego on 6/19/13.
//  Copyright (c) 2013 CoffeCode. All rights reserved.

#import "StageCollectionViewController.h"
#import "DailyViewController.h"

@implementation StageCollectionViewController

-(void)viewDidLoad {
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.stages = [NSArray arrayWithObjects:
               @"BMO Harris Pavilion",
               @"Briggs & Stratton Big Backyard",
               @"Harley-Davidson Roadhouse",
               @"Johnson Controls World Sound Stage",
               @"Marcus Amphitheater",
               @"Miller Lite Oasis",
               @"U.S. Cellular Connection Stage",
               @"Uline Warehouse", nil];
    UIColor *color1 = [UIColor colorWithRed:255.0/255.0 green:85.00/255.0 blue:55.00/255.0 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:255.0/255.0 green:103.00/255.0 blue:77.00/255.0 alpha:1.0];
    UIColor *color3 = [UIColor colorWithRed:255.0/255.0 green:200.00/255.0 blue:5.00/255.0 alpha:1.0];
    UIColor *color4 = [UIColor colorWithRed:255.0/255.0 green:217.00/255.0 blue:1.00/255.0 alpha:1.0];
    UIColor *color5 = [UIColor colorWithRed:0.0/255.0 green:212.00/255.0 blue:251.00/255.0 alpha:1.0];
    UIColor *color6 = [UIColor colorWithRed:0.0/255.0 green:189.00/255.0 blue:235.00/255.0 alpha:1.0];
    UIColor *color7 = [UIColor colorWithRed:3.0/255.0 green:237.00/255.0 blue:152.00/255.0 alpha:1.0];
    UIColor *color8 = [UIColor colorWithRed:0.0/255.0 green:251.00/255.0 blue:174.00/255.0 alpha:1.0];
    self.colors = [NSMutableArray arrayWithObjects: color1, color2, color3, color4, color5, color6, color7, color8, nil];
}

-(void)viewDidAppear:(BOOL)animated {
    self.collectionView.contentOffset = self.savedScrollPosition;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"stages" forIndexPath:indexPath];
    UILabel *stageName = (UILabel *)[cell viewWithTag:100];
    stageName.text = [self.stages objectAtIndex:indexPath.row];
    cell.backgroundColor = [self.colors objectAtIndex:indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //Animate
    UILabel *animateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    animateLabel.backgroundColor = [UIColor clearColor];
    animateLabel.text = [self.stages objectAtIndex:indexPath.row];
    animateLabel.textColor = [UIColor whiteColor];
    animateLabel.textAlignment = NSTextAlignmentCenter;
    [animateLabel setFont:[UIFont fontWithName: @"Futura" size: 19.0f]];
    if ([animateLabel.text isEqualToString:@"Johnson Controls World Sound Stage"]){
        [animateLabel setFont:[UIFont fontWithName: @"Futura" size: 16.0f]];
    }
    CGRect rect = [collectionView cellForItemAtIndexPath:indexPath].frame;
    self.savedScrollPosition = self.collectionView.contentOffset;
    rect = CGRectMake(rect.origin.x, (rect.origin.y-self.savedScrollPosition.y), rect.size.width, 160);
    UIView *animateview = [[UIView alloc] initWithFrame:rect];
    animateview.backgroundColor = [self.colors objectAtIndex:indexPath.row];
    [self.view addSubview:animateview];
    [animateview addSubview:animateLabel];
    [self.view bringSubviewToFront:animateview];
    [UIView animateWithDuration:.5
                     animations:^{
                         animateview.frame = CGRectMake(0.0f, 0.0f, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
                         animateLabel.frame = CGRectMake(20,15,280,26);
                     }
                     completion:^(BOOL finished){
                         [animateview removeFromSuperview];
                         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
                         DailyViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"dvc"];
                         dvc.backgroundImage = [self getBackgroundImage];
                         dvc.selectedIndex = indexPath;
                         dvc.savedScrollPosition = collectionView.contentOffset;
                         CGRect rect = [collectionView cellForItemAtIndexPath:indexPath].frame;
                         dvc.returnRectangle = CGRectMake(rect.origin.x, rect.origin.y-collectionView.contentOffset.y, rect.size.width, rect.size.height);
                         dvc.stageName = [self.stages objectAtIndex:indexPath.row];
                         dvc.stageColor = [self.colors objectAtIndex:indexPath.row];
                         //Complimentary color
                         NSInteger i = 0;
                         if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6) {
                             i = 1;
                         }
                         else {
                             i = -1;
                         }
                         dvc.complimentaryColor = [self.colors objectAtIndex:indexPath.row+i];
                         [self.navigationController pushViewController:dvc animated:NO];
                     }];
}

// Get current screen background for return transition
-(UIImage*)getBackgroundImage {
    CGSize size = CGSizeMake([[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height);
    UIGraphicsBeginImageContextWithOptions(size, true, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *transitionBackBackgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return transitionBackBackgroundImage;
}

@end
