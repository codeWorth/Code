//
//  startMinionsViewController.h
//  Souls
//
//  Created by Programming Account on 12/20/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface startMinionsViewController : UIViewController

@property (nonatomic, strong) NSArray *lowerLeftAlphas;
@property (nonatomic, strong) NSArray *lowerRightAlphas;
@property (nonatomic, strong) NSArray *middleLeftAlpas;
@property (nonatomic, strong) NSArray *middleRightAlphas;
@property (nonatomic, strong) NSArray *upperAlphas;

-(void)setAlphasForNumber:(NSInteger)tag;

@end
