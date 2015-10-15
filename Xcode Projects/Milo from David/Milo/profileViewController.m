//
//  profileViewController.m
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "profileViewController.h"
#import "settingsViewController.h"

@interface profileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *descLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation profileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dismissViewCancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewSave{
    [[NSUserDefaults standardUserDefaults] setObject:self.nameLabel.text forKey:@"myName"];
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(self.imageView.image) forKey:@"myImage"];
    [[NSUserDefaults standardUserDefaults] setObject:self.descLabel.text forKey:@"myDesc"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageView setClipsToBounds:YES];
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else
    {
        [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    self.imagePickerController.delegate = self;
    
    self.descLabel.delegate = self;
    self.nameLabel.delegate = self;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(dismissViewSave)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"myName"];
    self.descLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"myDesc"];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"myDesc"] isEqualToString:@""] || [[NSUserDefaults standardUserDefaults]objectForKey:@"myDesc"] == nil) {
        self.descLabel.text = @"No description here yet.";
    }
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"myImage"];
    if (imageData == nil) {
        self.imageView.image = [UIImage imageNamed:@"miloCatPhoto.png"];
    } else {
        UIImage* image = [UIImage imageWithData:imageData];
        self.imageView.image = image;
    }
    
    UIImage *backButtonImage = [UIImage imageNamed:@"miloBack.png"];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:backButtonImage forState:UIControlStateNormal];//this line for set only image on button
    backbutton.frame = CGRectMake(0, 0, backButtonImage.size.width/2.2, backButtonImage.size.height/2.2);
    [backbutton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    [backbutton addTarget:self action:@selector(dismissViewCancel) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = back;
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

- (IBAction)editImage:(UIButton *)sender {
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageView setImage:image];
    
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
