//
//  UserModel.m
//  apiclient
//
//  Created by iBo on 17/10/14.
//  Copyright (c) 2014 iBo. All rights reserved.
//

#import "UserModel.h"

@implementation BaseUser

+ (NSDictionary *) objectMapping
{
    return @{ @"userId":@"id", @"username":@"username" };
}

@end

@implementation UserModel

+ (NSDictionary *) objectMapping
{
    NSMutableDictionary *mapping = [NSMutableDictionary dictionaryWithDictionary:[super objectMapping]];
    [mapping setValuesForKeysWithDictionary:@{ @"about":@"about", @"surname":@"surname", @"name":@"name", @"git":@"git" }];
    return mapping;
}

@end
