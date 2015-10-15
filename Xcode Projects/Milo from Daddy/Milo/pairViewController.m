//
//  pairViewController.m
//  Milo
//
//  Created by Programming Account on 1/18/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "pairViewController.h"
#import "miloAppDelegate.h"

@interface pairViewController ()

@property (nonatomic, weak) miloAppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@end

@implementation pairViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dismissViewCancel{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewCancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
     self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (!self.appDelegate.d.t) {
        if (!self.appDelegate.d){
            self.appDelegate.d = [[KeyFobDelegate alloc]init];
            self.appDelegate.d.TIBLEConnectBtn = self.connectButton;
        }
        
        self.appDelegate.d.t = [[TIBLECBKeyfob alloc] init];   // Init TIBLECBKeyfob class.
        [self.appDelegate.d.t controlSetup:1];                 // Do initial setup of TIBLECBKeyfob class.
        self.appDelegate.d.t.delegate = self.appDelegate.d;    // Set TIBLECBKeyfob delegate class to point at methods implemented in this class.
    } else {
        [self.connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    }
    
    UIImage *backButtonImage = [UIImage imageNamed:@"miloBack.png"];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:backButtonImage forState:UIControlStateNormal];//this line for set only image on button
    backbutton.frame = CGRectMake(0, 0, backButtonImage.size.width/2.2, backButtonImage.size.height/2.2);
    [backbutton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    [backbutton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = back;
}

-(void) backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)connectToMilo:(UIButton *)sender {
    if (self.appDelegate.d.t.activePeripheral) {
        if(self.appDelegate.d.t.activePeripheral.state == CBPeripheralStateConnected) {
            [[self.appDelegate.d.t CM] cancelPeripheralConnection:[self.appDelegate.d.t activePeripheral]];
            [sender setTitle:@"Connect with Milo" forState:UIControlStateNormal];
            self.appDelegate.d.t.activePeripheral = nil;
            
            UIImage *miloImage = [UIImage imageNamed:@"notPaired.png"];
            UIButton *miloButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [miloButton setImage:miloImage forState:UIControlStateNormal];
            miloButton.frame = CGRectMake(0, 0, miloImage.size.width/2.2, miloImage.size.height/2.2);
            [miloButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [miloButton setShowsTouchWhenHighlighted:NO];
            UIBarButtonItem *milo = [[UIBarButtonItem alloc] initWithCustomView:miloButton];
            self.navigationItem.rightBarButtonItem = milo;
        }
    } else {
        if (self.appDelegate.d.t.peripherals){
            self.appDelegate.d.t.peripherals = nil;
        }
        [self.appDelegate.d.t findBLEPeripherals:5];
    }
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
