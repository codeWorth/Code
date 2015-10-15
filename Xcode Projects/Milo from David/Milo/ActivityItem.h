//
//  activityItem.h
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityItem : NSObject

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *time;
@property (nonatomic) NSInteger times;

+(id)itemWithDate:(NSString *)date andTime:(NSString *)time;

@end
