//
//  SoulStructure.m
//  Souls
//
//  Created by Programming Account on 12/25/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "SoulStructure.h"
#import "MagicType.h"

@implementation SoulStructure

-(id)initWithSub1:(SoulStructure *)sub1 sub2:(SoulStructure *)sub2 type:(NSString *)type andAlphas:(NSArray *)alphas{
    if (self = [super init]) {
        self.sub1 = sub1;
        self.sub2 = sub2;
        self.type = type;
        self.isRoot = NO;
        self.type = [MagicType typeFromType:sub1.type andOtherType:sub2.type];
        self.isSelected = NO;
        self.alphas = alphas;
    }
    return self;
}

-(id)initAsParentForSub1:(SoulStructure *)sub1{
    if (self = [super init]) {
        self.sub1 = sub1;
        self.sub2 = nil;
        self.sub1.parent = self;
        self.type = @"";
        self.isRoot = NO;
        self.isSelected = NO;
        self.alphas = @[@(0.0), @(0.0), @(0.0), @(0.0)];
    }
    return self;
}

-(id)init{
    if (self = [super init]) {
        self.alphas = @[@(0.0), @(0.0), @(0.0), @(0.0)];
        self.type = @"";
    }
    return self;
}

-(id)initAsRootWithType:(NSString *)type andAlphas:(NSArray *)alphas{
    if (self = [super init]) {
        self.type = type;
        self.isRoot = YES;
        self.isSelected = NO;
        self.alphas = alphas;
    }
    return self;
}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
}

-(SoulStructure *)findSelected{
    if (self.isRoot) {
        if (self.isSelected) {
            return self;
        } else {
            return nil;
        }
    } else {
        if (self.isSelected) {
            return self;
        } else {
            SoulStructure *foundLeft = [self.sub1 findSelected];
            if (foundLeft == nil) {
                return [self.sub2 findSelected];
            } else {
                return foundLeft;
            }
        }
    }
}

-(SoulStructure *)topOfStruct{
    if (self.parent == nil) {
        return self;
    } else {
        return [self.parent topOfStruct];
    }
}

-(NSInteger)heightOfStruct{
    if (self.isRoot) {
        return 1;
    } else {
        return [self.sub1 heightOfStruct] + 1;
    }
}

+(BOOL)alphasAreZeros:(NSArray *)alphas{
    for (NSNumber *number in alphas) {
        if (number.doubleValue != 0.0) {
            return false;
        }
    }
    return true;
}

-(void)setSub1:(SoulStructure *)sub1{
    _sub1 = sub1;
    if (self.sub1 != nil && self.sub2 != nil) {
        self.type = [MagicType typeFromType:self.sub1.type andOtherType:self.sub2.type];
    }
}

-(void)setSub2:(SoulStructure *)sub2{
    _sub2 = sub2;
    if (self.sub1 != nil && self.sub2 != nil) {
        self.type = [MagicType typeFromType:self.sub1.type andOtherType:self.sub2.type];
    }
}

-(BOOL)isSafeStructure{
    if (self.isRoot) {
        if (![self.type isEqual:@""] && self.type != nil) {
            return YES;
        } else {
            return NO;
        }
    } else {
        if (![self.type isEqual:@""] && self.type != nil && self.sub1 != nil && self.sub2 != nil) {
            if ([self.sub1 isSafeStructure] && [self.sub2 isSafeStructure]) {
                return YES;
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    }
}

@end
