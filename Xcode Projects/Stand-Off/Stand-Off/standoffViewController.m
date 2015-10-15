//
//  standoffViewController.m
//  Stand-Off
//
//  Created by Programming Account on 8/19/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "standoffViewController.h"
#import "standoffMyScene.h"

@interface standoffViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *secondaryButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *primaryButtons;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *primaryTexts;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *secondaryTexts;


@end

@implementation standoffViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    [self.navigationController setNavigationBarHidden: YES animated:YES];
    
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    SKScene * scene = [standoffMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void) hideAll{
    for (UIButton *button in self.primaryButtons){
        [button setHidden:YES];
    }
    for (UIButton *button in self.secondaryButtons){
        [button setHidden:YES];
    }
    for (UIImageView *image in self.primaryTexts){
        [image setHidden:YES];
    }
    for (UIImageView *image in self.secondaryTexts){
        [image setHidden:YES];
    }
}

-(void) showPrimary{
    for (UIButton *button in self.primaryButtons){
        [button setHidden:NO];
    }
    for (UIImageView *image in self.primaryTexts){
        [image setHidden:NO];
    }
}

- (IBAction)switchWeapon {
    for (UIButton *button in self.primaryButtons){
        [button setHidden:YES];
    }
    for (UIImageView *image in self.primaryTexts){
        [image setHidden:YES];
    }
    for (UIButton *button in self.secondaryTexts){
        [button setHidden:NO];
    }
    for (UIImageView *image in self.secondaryButtons){
        [image setHidden:NO];
    }
}


- (IBAction)pass {
    [self hideAll];
}

- (IBAction)dodge {
    [self hideAll];
}

- (IBAction)shoot {
    [self hideAll];
}

@end
