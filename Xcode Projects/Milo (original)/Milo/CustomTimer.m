//
//  CustomTimer.m
//  Milo
//
//  Created by Programming Account on 1/17/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "CustomTimer.h"

@implementation CustomTimer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]) {
        [self setDefaultAngle];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat centerX = self.bounds.origin.x + self.bounds.size.width/2;
    CGFloat centerY = self.bounds.origin.y + self.bounds.size.height/2;
    
    UIColor *color = [UIColor colorWithRed:0.6 green:0.3 blue:0.3 alpha:0.75];
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextMoveToPoint(context, centerX, centerY);
    CGContextAddLineToPoint(context, centerX, self.bounds.origin.y);
    CGContextAddArc(context, centerX, centerY, centerX, 3*M_PI/2, self.angle, 1);
    CGContextAddLineToPoint(context, centerX, centerY);
    
    CGContextFillPath(context);
}

-(void)setDefaultAngle{
    self.angle = -M_PI/2;
}

@end
