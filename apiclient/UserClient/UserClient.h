//
//  UserClient.h
//  apiclient
//
//  Created by iBo on 17/10/14.
//  Copyright (c) 2014 iBo. All rights reserved.
//

#import "ApiHTTPClient.h"

@interface UserClient : ApiHTTPClient
- (AFHTTPRequestOperation *) getUser:(AFHTTPRequestOperationBlockSuccess)block;
- (AFHTTPRequestOperation *) getError:(AFHTTPRequestOperationBlockSuccess)block;
@end