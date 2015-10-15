//
//  Checklists.h
//  Checklists
//
//  Created by Baby Andrew on 8/19/13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *checklistItems;

@end
