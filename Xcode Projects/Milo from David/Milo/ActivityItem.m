//
//  activityItem.m
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "ActivityItem.h"

@implementation ActivityItem

-(id)initWithDate:(NSString *)date andTime:(NSString *)time{
    if (self = [super init]) {
        self.date = date;
        self.time = time;
        self.times = 1;
    }
    return self;
}

+(id)itemWithDate:(NSString *)date andTime:(NSString *)time{
    ActivityItem *item = [[ActivityItem alloc]initWithDate:date andTime:time];
    return item;
}

@end
