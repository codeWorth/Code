//
//  multiuserTestTableViewController.m
//  MultiuserTest
//
//  Created by Programming Account on 5/26/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "multiuserTestTableViewController.h"

@interface multiuserTestTableViewController ()

@property (nonatomic, strong) NetHandler *netHandle;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NetHandler *net;

-(void)addPossibleClient:(NSNetService *)client;
-(void)addPossibleClients:(NSArray *)clients;
-(void)loadInitialData;

@end

@implementation multiuserTestTableViewController

-(void)addPossibleClient:(NSNetService *)client{
    //addClient
}

-(void)addPossibleClients:(NSArray *)clients{
    for (NSNetService *client in clients) {
        if ([clients isKindOfClass:[NSNetService class]]) {
            [self addPossibleClient:client];
        }
    }
}

-(void)loadInitialData{
    ConnectorCanidate *additem1 = [[ConnectorCanidate alloc]init];
    additem1.name = @"ThebadDog";
    additem1.description = @"Much bad. Very not good. Very not punish please.";
    additem1.image = [UIImage imageNamed:@"dog.png"];
    [self.items addObject:additem1];
    
    ConnectorCanidate *additem2 = [[ConnectorCanidate alloc]init];
    additem2.name = @"Catno";
    additem2.description = @"Play with the dog they said. You will have fun they said.";
    additem2.image = [UIImage imageNamed:@"grumpy_cat.png"];
    [self.items addObject:additem2];
    
    ConnectorCanidate *additem3 = [[ConnectorCanidate alloc]init];
    additem3.name = @"PlsAdpotThem";
    additem3.description = @"I have only done 2 things that I regret in my life. 1: getting my cat and my dog, and 2: not having 2 things that I regret in my life";
    additem3.image = [UIImage imageNamed:@"facepalm.png"];
    [self.items addObject:additem3];
}

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
    
    self.netHandle = [[NetHandler alloc]initWithName:self.title];
    self.items = [[NSMutableArray alloc]init];
    self.tableView.delegate = self;
    [self loadInitialData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ProfileCell"];
    }
    
    ConnectorCanidate *connector = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = connector.name;
    cell.detailTextLabel.text = connector.description;
    cell.imageView.image = connector.image;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UITableViewCell *cellSender = sender;
    [segue.destinationViewController setTitle:cellSender.textLabel.text];
    moreInfoViewController *destination = segue.destinationViewController;
    destination.connectorDesc = cellSender.detailTextLabel.text;
    destination.connectorImage = cellSender.imageView.image;
    
}

@end
