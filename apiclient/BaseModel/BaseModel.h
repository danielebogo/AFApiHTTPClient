//
//  BaseModel.h
//  apiclient
//
//  Created by iBo on 17/10/14.
//  Copyright (c) 2014 iBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
+ (NSDictionary *) objectMapping;

- (id) initWithDictionary:(NSDictionary *)dictionary;
- (void) setData:(NSDictionary *)dictionary;
@end
