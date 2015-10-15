//
//  Pin.h
//  TowersOfHanoiFix
//
//  Created by Programming Account on 1/5/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ring.h"

@interface Pin : NSObject

@property(strong, nonatomic) NSMutableArray *rings;

-(NSInteger)ringsAboveRingNumber:(NSInteger)ringNumber;
-(Ring *)removeAndReturnLastRing;
-(NSString *)placeRingOnSelf:(Ring *)ring;
-(instancetype)initWithRings:(NSArray *)rings;
-(NSMutableString *)description;
//-(Pin *)copy;

@end
