//
//  MagicType.h
//  Souls
//
//  Created by Programming Account on 4/1/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Soul;
@class Minion;

//Represents a type of Magic and how it interacts with souls and minions.

@interface MagicType : NSObject <NSCoding>

@property (nonatomic, strong) NSString* type; //the string the is the type of magic.
@property (nonatomic) double amount; //how much of the magic. Should be used in SpellCard's castFunc to translate this number to damage, healing, etc...
@property (nonatomic, strong)NSArray *creatorMagic; //of Magic. What magic was combined to make this one.

-(double)interactWithMinion:(Minion *)minion; //affects on the magic when cast by the minion.
-(double)blockMinion:(Minion *)minion; //affect on the magic when cast on the minion
- (BOOL)isEqual:(id)otherMagic; //tests if it is the same as another magic, regardless of amount.

-(id)initWithMagic:(MagicType *)magic1 otherMagic:(MagicType *)magic2 andAmount:(double)amount; //this is the best way to initalize.

+(NSString *)typeFromType:(NSString *)type1 andOtherType:(NSString *)type2; //a class method that returns what 2 types of magic combine to make another magic type as a string.
+(NSMutableArray *)combineMagicList:(NSArray *)array1 andOtherMagicList:(NSMutableArray *)array2; //combines a list of magic with another, adding amounts when the types are the same.
+(NSMutableArray *)combineMagicList:(NSMutableArray *)array withMagic:(MagicType *)magic; //adds a single magic to a list.

-(MagicType *)copy;

-(void)encodeWithCoder:(NSCoder *)aCoder;
-(id)initWithCoder:(NSCoder *)aDecoder;

@end
