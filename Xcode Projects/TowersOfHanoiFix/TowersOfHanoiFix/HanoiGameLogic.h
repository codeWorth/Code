//
//  HanoiGame.h
//  TowersOfHanoiFix
//
//  Created by Programming Account on 1/5/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HanoiGame.h"

@interface HanoiGameLogic : HanoiGame

-(NSArray *)towerSolve;
-(instancetype)initWithRings:(NSInteger)numOfRings;

@end
