//
//  netHandler.h
//  MultiuserTest
//
//  Created by Programming Account on 5/26/14.
//  Copyright (c) 2014 Programming Account. All rights reserved.
//

#import <Foundation/Foundation.h>
@class multiuserTestViewController;

@protocol NetHandlerDelegate <NSObject>

-(NSNetService *)chooseServiceFromServices:(NSMutableArray *)services;

@end

@interface NetHandler : NSObject <NSNetServiceBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *possibleConnectors;

-(instancetype)initWithName:(NSString *)name;
-(void)listenForConnections;

@property (nonatomic, weak) id <NetHandlerDelegate> delegate;

@end
