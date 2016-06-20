//
//  ViewController.h
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Spell.h"

@interface BattlefieldController : UIViewController

-(void)cancelCast;
-(void)castSpell:(NSObject<Spell>*)spell;

@end

