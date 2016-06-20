//
//  DetailViewController.h
//  test
//
//  Created by Andrew Cummings on 6/6/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

