//
//  ApiHTTPClient.h
//  Daniele Bogo
//
//  Created by iBo on 10/3/13.
//  Copyright (c) 2013 Daniele Bogo. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^AFHTTPRequestOperationBlockError)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^AFHTTPRequestOperationBlockSuccess)(AFHTTPRequestOperation *operation, id responseObject);

@interface ApiHTTPClient : AFHTTPRequestOperationManager
@property (nonatomic, copy) AFHTTPRequestOperationBlockError errorBlock;
@property (nonatomic, copy) AFHTTPRequestOperationBlockSuccess successBlock;
@property (nonatomic, assign, getter=isAllOperationCancelled) BOOL cancelAllOperations;

+ (instancetype) client;

- (void) startReachabilityMonitor;
- (void) checkAndCancelAllOperations;
- (NSDictionary *) baseParameters:(NSDictionary *)dictionary includingAuthentication:(BOOL)auth;
- (NSMutableURLRequest *) requestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters;
@end

@interface ApiHTTPClient (NewOperationMethods)
- (AFHTTPRequestOperation *) GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(AFHTTPRequestOperationBlockSuccess)success;
- (AFHTTPRequestOperation *) POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(AFHTTPRequestOperationBlockSuccess)success;
- (AFHTTPRequestOperation *) PUT:(NSString *)URLString parameters:(NSDictionary *)parameters success:(AFHTTPRequestOperationBlockSuccess)success;
- (AFHTTPRequestOperation *) DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(AFHTTPRequestOperationBlockSuccess)success;
@end

@interface AFHTTPRequestOperation (SuccessLog)
- (void) successLog;
@end

@interface NSDictionary (Succeeded)
- (BOOL) succeeded;
- (BOOL) newUser;
- (NSString *) errorMessage;
- (void) showError;
@end