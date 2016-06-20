//
//  minionScreenViewController.h
//  Souls
//
//  Created by Programming Account on 12/24/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Minion;

@interface minionScreenViewController : UIViewController 

@property (nonatomic) NSInteger numberOfFire;
@property (nonatomic) NSInteger numberOfWater;
@property (nonatomic) NSInteger numberOfRock;
@property (nonatomic) NSInteger numberOfAir;
@property (nonatomic) NSInteger numberToSet;

@property (nonatomic) NSInteger numberOfSoulPoints;
@property (nonatomic) NSInteger costToCreate;

@property (strong, nonatomic) Minion *minion;

-(UIView *)viewWithTag:(NSInteger)tag inArray:(NSArray *)array;

@end
