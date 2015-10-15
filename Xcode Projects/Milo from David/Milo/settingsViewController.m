//
//  settingsViewController.m
//  Milo
//
//  Created by Programming Account on 1/18/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "settingsViewController.h"
#import "miloAppDelegate.h"

@interface settingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *catName;
@property (weak, nonatomic) IBOutlet UIImageView *catImage;

@end

@implementation settingsViewController

-(void)updateProfile{
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"myImage"];
    if (imageData == nil) {
        self.catImage.image = [UIImage imageNamed:@"miloCatPhoto.png"];
    } else {
        UIImage* image = [UIImage imageWithData:imageData];
        self.catImage.image = image;
    }
    
    self.catName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"myName"];
    if ([self.catName.text isEqualToString:@""]) {
        self.catName.text = @"Miblee";
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
    self.catImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.catImage setClipsToBounds:YES];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"miloBack.png"];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:backButtonImage forState:UIControlStateNormal];//this line for set only image on button
    backbutton.frame = CGRectMake(0, 0, backButtonImage.size.width/2.2, backButtonImage.size.height/2.2);
    [backbutton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    [backbutton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = back;
    
    [self updateProfile];
    
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
    
    UIImage *titleImage = [UIImage imageNamed:@"miloSettings.png"];
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(-6, 0, titleImage.size.width/2.2, titleImage.size.height/2.05)];
    UIView *titleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleImage.size.width/2.2, titleImage.size.height/2.05)];
    [titleContainer addSubview:titleView];
    titleView.image = titleImage;
    self.navigationItem.titleView = titleContainer;
}

-(void) backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [self updateProfile];
    
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
