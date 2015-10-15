//
//  Ring.h
//  TowersOfHanoiFix
//
//  Created by Programming Account on 1/5/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ring : NSObject

@property(nonatomic) NSInteger size;

-(instancetype)initWithSize:(NSInteger)size;
-(NSString *)description;

@end
