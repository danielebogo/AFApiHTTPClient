//
//  UserClient.m
//  apiclient
//
//  Created by iBo on 17/10/14.
//  Copyright (c) 2014 iBo. All rights reserved.
//

#import "UserClient.h"

@implementation UserClient

- (AFHTTPRequestOperation *) getUser:(AFHTTPRequestOperationBlockSuccess)block
{
    return [self GET:@"user.json" parameters:nil success:block];
}

- (AFHTTPRequestOperation *) getError:(AFHTTPRequestOperationBlockSuccess)block
{
    return [self GET:@"error.json" parameters:nil success:block];
}

@end