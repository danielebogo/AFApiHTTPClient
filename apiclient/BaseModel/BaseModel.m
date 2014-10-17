//
//  BaseModel.m
//  apiclient
//
//  Created by iBo on 17/10/14.
//  Copyright (c) 2014 iBo. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+ (NSDictionary *) objectMapping
{
    return nil;
}

- (id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if ( self ) {
        [self setData:dictionary];
    }
    
    return self;
}

- (void) setData:(NSDictionary *)dictionary
{
    [[[self class] objectMapping] enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        if (  dictionary[value] && [self respondsToSelector:NSSelectorFromString(key)] ) {
            [self setValue:dictionary[value] forKey:key];
        }
    }];
}
@end
