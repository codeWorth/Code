//
//  moreInfoViewController.m
//  MultiuserTest
//
//  Created by Programming Account on 5/31/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "moreInfoViewController.h"

@interface moreInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextView *connectorInfo;
@property (weak, nonatomic) IBOutlet UIImageView *connectorImageView;

@end

@implementation moreInfoViewController

- (IBAction)connectWithPerson {
    NSString *message = [NSString stringWithFormat:@"Connecting with %@, actually not really but just believe.", self.title];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connecting..." message:message delegate:nil cancelButtonTitle:@"Ok." otherButtonTitles:nil];
    [alert show];
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
    self.connectorInfo.text = self.connectorDesc;
    self.connectorImageView.image = self.connectorImage;
    self.connectorImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.connectorInfo.textAlignment = NSTextAlignmentCenter;
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

@end
