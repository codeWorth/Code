//
//  multiuserTestViewController.m
//  MultiuserTest
//
//  Created by Programming Account on 5/26/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "multiuserTestViewController.h"
#import "editProfileViewController.h"

@interface multiuserTestViewController ()

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NetHandler *net;

@end

@implementation multiuserTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.searchButton.enabled = NO;
    self.title = self.name;
    self.descriptionLabel.text = self.description;
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.image = self.image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)name{
    if (!_name) {
        _name = @"Your Name Here";
    }
    return _name;
}

-(NSString *)description{
    if (!_description) {
        _description = @"Your description here";
    }
    return _description;
}

-(UIImage *)image{
    if (!_image) {
        _image = [UIImage imageNamed:@"icon-user-default.png"];
    }
    return _image;
}

- (IBAction)search {
    self.net = [[NetHandler alloc]initWithName:self.name];
    self.net.delegate = self;
    [self.net listenForConnections];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        editProfileViewController *dest = segue.destinationViewController;
        dest.name = self.name;
        dest.description = self.description;
        dest.image = self.image;
        dest.sender = self;
        [dest updateUI];
    }
}

-(void)updateUI{
    self.title = self.name;
    self.descriptionLabel.text = self.description;
    self.imageView.image = self.image;
    if ([self.name length] > 0) {
        self.searchButton.enabled = YES;
    } else {
        self.searchButton.enabled = NO;
    }
}

-(NSNetService *)chooseServiceFromServices:(NSMutableArray *)services{
    return services[0];
}

@end
