//
//  netHandler.m
//  MultiuserTest
//
//  Created by Programming Account on 5/26/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import "NetHandler.h"

@interface NetHandler ()

@property (nonatomic, strong) NSNetService *netService;
@property (nonatomic, strong) NSNetServiceBrowser *browser;

@end

@implementation NetHandler

-(NSMutableArray *)possibleConnectors{
    if (!_possibleConnectors) {
        _possibleConnectors = [NSMutableArray array];
    }
    return _possibleConnectors;
}

-(instancetype)initWithName:(NSString *)name{
    if (self=[super init]) {
        self.netService = [[NSNetService alloc]initWithDomain:@"" type:@"_souls._tcp" name:name port:0];
        [self.netService resolveWithTimeout:5.0];
    }
    return self;
}

-(instancetype)init{
    if (self = [super init]) {
        self.netService = [[NSNetService alloc]initWithDomain:@"" type:@"_souls._tcp" name:@"Unknown" port:0];
    }
    return self;
}

-(void)listenForConnections{
    self.browser = [NSNetServiceBrowser new];
    [self.netService publishWithOptions:NSNetServiceListenForConnections];
    [self.browser setDelegate:self];
    [self.browser searchForServicesOfType:self.netService.type inDomain:self.netService.domain];
}

//NSNetServiceBrowserDelegate methods

-(void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing{
    NSLog(@"Found a Service named: %@",aNetService.name);
    [self.possibleConnectors addObject:aNetService];
    if (!moreComing) {
        NSLog(@"All done!");
    }
}

-(void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)aNetServiceBrowser{
    NSNetService *wantedNet = [self.delegate chooseServiceFromServices:self.possibleConnectors];
}

@end
