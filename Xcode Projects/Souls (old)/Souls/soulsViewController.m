//
//  soulsViewController.m
//  Souls
//
//  Created by Programming Account on 3/30/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "soulsViewController.h"

@interface soulsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation soulsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.startButton.titleLabel.font = [UIFont fontWithName:@"Ringbearer" size:81.0];
    
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.backgroundImage.frame.size.width, self.backgroundImage.frame.size.height)];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
    [self.backgroundImage addSubview:overlay];
    
    [self animateLayer:overlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animateLayer:(UIView *) layer {
    
    [UIView animateWithDuration:4.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGFloat alpha;
        CGFloat white;
        [layer.backgroundColor getWhite:&white alpha:&alpha];
        if (alpha == 0.0) {
            [layer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        } else {
            [layer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
        }
    } completion:^(BOOL b) {
        [self animateLayer:layer];
    }];
}

@end
