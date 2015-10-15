//
//  leaderboardTableViewController.m
//  Milo
//
//  Created by Programming Account on 1/5/15.
//  Copyright (c) 2015 milo. All rights reserved.
//

#import "leaderboardTableViewController.h"
#import "leaderboardTableViewCell.h"
#import "infoPageViewController.h"
#import "LeaderItem.h"
#import "miloAppDelegate.h"

@interface leaderboardTableViewController ()

@property (nonatomic, strong) NSArray *leaders;

@end

@implementation leaderboardTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f);
    
    self.leaders = [NSArray arrayWithObjects:[LeaderItem itemWithName:@"Miblee" score:632 description:@"Miblee is the best cat in the world. She's friendly, fuzzy, and happy. Miblee is a grey furred Siamese cat. Miblee hobbies include chasing mice, sitting on my lap, and being the best in the world at Milo!" andImage:[UIImage imageNamed:@"cat.jpg"]], [LeaderItem itemWithName:@"Emma" score:545 description:@"Emma is my favourite cat. Although she can be rather aloof at times, when she does honour you with her pressence it is like the Queen herself is sitting on your lap. Emma is an outdoor cat, but when she is inside she loves batting around the Milo toy." andImage:[UIImage imageNamed:@"cat2.jpg"]], [LeaderItem itemWithName:@"Harry" score:495 description:@"Harry has no equal. He is kind, and always tries to be near me. He is very fuzzy and cute, but his positives don't stop there. He loves sitting on laps, and is extremely affectionate. Harry loves playing with Milo as he is an indoor cat, and my I enjoy playing with Harry." andImage:[UIImage imageNamed:@"cat3.jpg"]], nil];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"miloBack.png"];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setImage:backButtonImage forState:UIControlStateNormal];//this line for set only image on button
    backbutton.frame = CGRectMake(0, 0, backButtonImage.size.width/2.2, backButtonImage.size.height/2.2);
    [backbutton setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    [backbutton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = back;
    
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

-(void) backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.leaders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CatDetail";
    
    leaderboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell.delegate == nil) {
        cell.delegate = self;
    }
    
    LeaderItem *thisItem = self.leaders[indexPath.row];
    cell.catImage.image = thisItem.catPhoto;
    cell.catScore.text = [NSString stringWithFormat:@"%li", (long)thisItem.score];
    cell.catName.text = thisItem.name;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    infoPageViewController *dest = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"infoSegue"]) {
        leaderboardTableViewCell *cell = sender;
        UITableView *table = (UITableView *)cell.superview.superview;
        LeaderItem *item = self.leaders[[table indexPathForCell:cell].row];
        dest.itemToDisplay = item;
        
    }
}

-(void)showInfoPageForCell:(UITableViewCell *)cell{
    [self performSegueWithIdentifier:@"infoSegue" sender:cell];
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
