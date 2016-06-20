//
//  SoulStructure.h
//  Souls
//
//  Created by Programming Account on 12/25/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoulStructure : NSObject

@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) SoulStructure *sub1;
@property (strong,nonatomic) SoulStructure *sub2;
@property (nonatomic) BOOL isRoot;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) NSInteger posInLevel;
@property (strong, nonatomic) NSArray *alphas;
@property (weak, nonatomic) SoulStructure *parent;

-(SoulStructure *)findSelected;
-(NSInteger)heightOfStruct; //call on topOfStruct
-(SoulStructure *)topOfStruct;
+(BOOL)alphasAreZeros:(NSArray *)alphas;
-(BOOL)isSafeStructure;

-(id)initWithSub1:(SoulStructure *)sub1 sub2:(SoulStructure *)sub2 type:(NSString *)type andAlphas:(NSArray *)alphas;
-(id)initAsParentForSub1:(SoulStructure *)sub1;
-(id)initAsRootWithType:(NSString *)type andAlphas:(NSArray *)alphas;


@end
