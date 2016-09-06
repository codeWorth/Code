//
//  startMinionsViewController.m
//  Souls
//
//  Created by Programming Account on 12/20/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "startMinionsViewController.h"
#import "minionScreenViewController.h"
#import "SoulStructure.h"

@interface startMinionsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *soulPointsLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *lowerLeftSouls;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *middleRightSouls;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *middleLeftSouls;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *upperSouls;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *lowerRightSouls;
@property (weak, nonatomic) IBOutlet UIButton *lowerLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *lowerRightButton;
@property (weak, nonatomic) IBOutlet UIButton *middleLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *middleRightButton;
@property (weak, nonatomic) IBOutlet UIButton *upperButton;


@property (nonatomic) NSInteger soulPoints;

@end

@implementation startMinionsViewController

-(void)setAlphasForNumber:(NSInteger)tag{
    if (tag == 1) {
        [self.lowerLeftButton setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        if ([SoulStructure alphasAreZeros:self.lowerLeftAlphas]) {
            [self.lowerLeftButton setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        }
        [self setAlphasOnArray:self.lowerLeftSouls fromArray:self.lowerLeftAlphas];
    } else if (tag == 2) {
        [self.lowerRightButton setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        if ([SoulStructure alphasAreZeros:self.lowerRightAlphas]) {
            [self.lowerRightButton setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        }
        [self setAlphasOnArray:self.lowerRightSouls fromArray:self.lowerRightAlphas];
    } else if (tag == 3) {
        [self.middleLeftButton setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        if ([SoulStructure alphasAreZeros:self.middleLeftAlpas]) {
            [self.middleLeftButton setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        }
        [self setAlphasOnArray:self.middleLeftSouls fromArray:self.middleLeftAlpas];
    } else if (tag == 4) {
        [self.middleRightButton setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        if ([SoulStructure alphasAreZeros:self.middleRightAlphas]) {
            [self.middleRightButton setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        }
        [self setAlphasOnArray:self.middleRightSouls fromArray:self.middleRightAlphas];
    } else if (tag == 5) {
        [self.upperButton setBackgroundImage:[UIImage imageNamed:@"circleWithoutText.png"] forState:UIControlStateNormal];
        if ([SoulStructure alphasAreZeros:self.upperAlphas]) {
            [self.upperButton setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        }
        [self setAlphasOnArray:self.upperSouls fromArray:self.upperAlphas];
    }
}

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
    
    //self.startButton.titleLabel.font = [UIFont fontWithName:@"Ringbearer" size:81.0];
    
    [self setAlphasForNumber:1];
    [self setAlphasForNumber:2];
    [self setAlphasForNumber:3];
    [self setAlphasForNumber:4];
    [self setAlphasForNumber:5];
    
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.backgroundImage.frame.size.width, self.backgroundImage.frame.size.height)];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self.backgroundImage addSubview:overlay];
    
    [self animateLayer:overlay];
    
    self.soulPoints = 13;
    self.soulPointsLabel.text = [NSString stringWithFormat:@"You have %i Soul Points", self.soulPoints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    minionScreenViewController *dest = [segue destinationViewController];
    dest.numberToSet = ((UIView *)sender).tag;
    dest.numberOfSoulPoints = self.soulPoints;
    dest.numberOfAir = 5;
    dest.numberOfFire = 7;
    dest.numberOfRock = 10;
    dest.numberOfWater = 3;
    dest.costToCreate = 0;
}


- (void)animateLayer:(UIView *) layer {
    
    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
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

-(void)setAlphasOnArray:(NSArray *)views fromArray:(NSArray *)alphas{
    if (alphas == nil) {
        for (UIView *view in views) {
            view.alpha = 0.0;
        }
    } else {
        for (int i = 1; i <= views.count; i++) {
            [self viewWithTag:i inArray:views].alpha = ((NSNumber *)alphas[i-1]).doubleValue;
            if (((NSNumber *)alphas[i-1]).doubleValue > 0) {
                [self viewWithTag:i inArray:views].hidden = NO;
            }
        }
    }
}

-(UIView *)viewWithTag:(NSInteger)tag inArray:(NSArray *)array{
    for (UIView *view in array) {
        if (view.tag == tag){
            return view;
        }
    }
    return nil;
}

@end
