//
//  miloNavController.m
//  Milo
//
//  Created by Andrew Cummings on 2/21/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "miloNavController.h"

@interface miloNavController ()

@end

@implementation miloNavController

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
    UIColor *barColor = [UIColor colorWithRed:166/256.0 green:216/256.0 blue:256/256.0 alpha:1];
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [barColor setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *gradientImage44 = image; //replace "nil" with your method to programmatically create a UIImage object with transparent colors for portrait orientation
    
    //customize the appearance of UINavigationBar
    [self.navigationBar setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBarStyle:UIBarStyleDefault];
    
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
