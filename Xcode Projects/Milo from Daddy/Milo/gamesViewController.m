//
//  gamesViewController.m
//  Milo
//
//  Created by Andrew Cummings on 2/22/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "gamesViewController.h"
#import "miloAppDelegate.h"

@interface gamesViewController ()

@end

@implementation gamesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *backButtonImage = [UIImage imageNamed:@"miloBack.png"];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:backButtonImage forState:UIControlStateNormal];//this line for set only image on button
    backbutton.frame = CGRectMake(0, 0, backButtonImage.size.width/2.2, backButtonImage.size.height/2.2);
    [backbutton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    [backbutton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = back;
    
    UIImage *titleImage = [UIImage imageNamed:@"miloGames.png"];
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(-15, 0, titleImage.size.width/1.8, titleImage.size.height/1.65)];
    UIView *titleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleImage.size.width/1.8, titleImage.size.height/1.65)];
    [titleContainer addSubview:titleView];
    titleView.image = titleImage;
    self.navigationItem.titleView = titleContainer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillAppear:(BOOL)animated{
    miloAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    UIImage *miloImage;
    if (appDelegate.d.t.activePeripheral.state == CBPeripheralStateConnected) {
        miloImage = [UIImage imageNamed:@"paired.png"];
    } else {
        miloImage = [UIImage imageNamed:@"notPaired.png"];
    }
    UIButton *miloButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [miloButton setImage:miloImage forState:UIControlStateNormal];
    miloButton.frame = CGRectMake(0, 0, miloImage.size.width/2.2, miloImage.size.height/2.2);
    [miloButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [miloButton setShowsTouchWhenHighlighted:NO];
    UIBarButtonItem *milo = [[UIBarButtonItem alloc] initWithCustomView:miloButton];
    self.navigationItem.rightBarButtonItem = milo;
}

@end
