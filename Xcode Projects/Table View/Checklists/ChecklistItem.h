//
//  ChecklistItem.h
//  Checklists
//
//  Created by Baby Andrew on 8/6/13.
//  Copyright (c) 2013 Hollance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject <NSCoding>

@property(nonatomic, strong)NSString *text;
@property(nonatomic, assign)BOOL checked;
-(void)toggleChecked;

@end
