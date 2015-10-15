//
//  Materials.h
//  SpaceNar
//
//  Created by Programming Account on 1/17/14.
//  Copyright (c) 2014 Baby Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Materials : NSObject

@property(nonatomic)NSInteger amount;
@property(nonatomic,strong)NSString *type;

-(instancetype)initWithAmount:(NSInteger)amount andType:(NSString *)type;

@end
