//
//  ApiHTTPClient.m
//  Daniele Bogo
//
//  Created by iBo on 10/3/13.
//  Copyright (c) 2013 Daniele Bogo. All rights reserved.
//

#import "ApiHTTPClient.h"

@interface ApiHTTPClient ()
- (NSMutableURLRequest *) addDefaultHeaderFieldsForRequest:(NSMutableURLRequest *)request;
- (NSSet *) contentTypes;
- (NSString *) absoluteURLStringFrom:(NSString *)URLString;
- (void) actionForStatusCode:(NSInteger)statusCode;
@end

@implementation ApiHTTPClient

+ (instancetype) client
{
    return [[[self class] alloc] init];
}

- (id) init
{
    self = [super initWithBaseURL:[NSURL URLWithString:@"http://bogodaniele.com/apps/development/apihttpclient"]];
    if (self) {
        NSLog(@"BASE %@", self.baseURL);
        [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [self startReachabilityMonitor];
    }
    return self;
}

- (void) startReachabilityMonitor
{
    NSOperationQueue *operationQueue = self.operationQueue;
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                NSLog(@"Reachability Ok");
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                NSLog(@"Reachability Ok");
                break;
        }
    }];
    
    [self.reachabilityManager startMonitoring];
}

- (void) checkAndCancelAllOperations
{
    if ( self.operationQueue.operationCount > 0 ) {
        [self.operationQueue cancelAllOperations];
        self.cancelAllOperations = YES;
    }
}

- (NSMutableURLRequest *) addDefaultHeaderFieldsForRequest:(NSMutableURLRequest *)request
{
//////////////////////////////////////////////////////////////////////
//                                                                  //
//  If you use default values within your request, add values here  //
//                                                                  //
//////////////////////////////////////////////////////////////////////

//    [request setValue:@"value" forHTTPHeaderField:@"key-field"];
    return request;
}

- (NSDictionary *) baseParameters:(NSDictionary *)dictionary includingAuthentication:(BOOL)auth
{
    NSMutableDictionary *defaultDictionary = [NSMutableDictionary dictionary];
    
/////////////////////////////////////////////////////////////////
//                                                             //
//  If you use default values to add in your query parameters  //
//                                                             //
/////////////////////////////////////////////////////////////////
    
    return [defaultDictionary copy];
}

- (NSMutableURLRequest *) requestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:nil];
#ifdef DEBUG
    [request setTimeoutInterval:180];
#else
    [request setTimeoutInterval:25];
#endif
    
    NSLog(@"PATH %@", request.URL);
    
    return [self addDefaultHeaderFieldsForRequest:request];
}

- (NSSet *) contentTypes
{
    return [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", nil];
}

- (NSString *) absoluteURLStringFrom:(NSString *)URLString
{
    return [[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString];
}

- (void) actionForStatusCode:(NSInteger)statusCode
{
    switch (statusCode) {
        case 401:
            break;
            
        case 404:
            break;
            
        case 500:
            break;
            
        default:
            break;
    }
}

#pragma mark - Override Blocks

- (AFHTTPRequestOperationBlockError) errorBlock
{
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperationBlockError errorBlock = ^( AFHTTPRequestOperation *operation, NSError *error ) {
        weakSelf.successBlock(operation, nil);
        
        [weakSelf actionForStatusCode:operation.response.statusCode];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"com.bg.error.notification" object:nil
                                                          userInfo:@{ @"operation":operation }];
        NSLog(@"------ REQUEST ERROR LOG START ------");
        NSLog(@"Request %@", [operation.request.URL absoluteString]);
        NSLog(@"Status Code %ld", (long)operation.response.statusCode);
        NSLog(@"Headers %@", operation.response.allHeaderFields);
        NSLog(@"Error %@", error.localizedDescription);
        NSLog(@"------ REQUEST ERROR LOG END ------");
    };
    
    return errorBlock;
}

#pragma mark - Override Methods

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(AFHTTPRequestOperationBlockSuccess)success
                        failure:(AFHTTPRequestOperationBlockError)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" URLString:[self absoluteURLStringFrom:URLString] parameters:parameters];
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    [operation.responseSerializer setAcceptableContentTypes:[self contentTypes]];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(AFHTTPRequestOperationBlockSuccess)success
                         failure:(AFHTTPRequestOperationBlockError)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" URLString:[self absoluteURLStringFrom:URLString] parameters:parameters];
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    [operation.responseSerializer setAcceptableContentTypes:[self contentTypes]];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                           success:(AFHTTPRequestOperationBlockSuccess)success
                           failure:(AFHTTPRequestOperationBlockError)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:@"DELETE" URLString:[self absoluteURLStringFrom:URLString] parameters:parameters];
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    [operation.responseSerializer setAcceptableContentTypes:[self contentTypes]];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(id)parameters
                        success:(AFHTTPRequestOperationBlockSuccess)success
                        failure:(AFHTTPRequestOperationBlockError)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:@"PUT" URLString:[self absoluteURLStringFrom:URLString] parameters:parameters];
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    [operation.responseSerializer setAcceptableContentTypes:[self contentTypes]];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end

@implementation ApiHTTPClient (NewOperationMethods)

#pragma mark - New Operation methods

- (AFHTTPRequestOperation *) GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(AFHTTPRequestOperationBlockSuccess)success
{
    [self setSuccessBlock:success];
    return [self GET:URLString parameters:parameters success:self.successBlock failure:self.errorBlock];
}

- (AFHTTPRequestOperation *) POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(AFHTTPRequestOperationBlockSuccess)success
{
    [self setSuccessBlock:success];
    return [self POST:URLString parameters:parameters success:self.successBlock failure:self.errorBlock];
}

- (AFHTTPRequestOperation *) PUT:(NSString *)URLString parameters:(NSDictionary *)parameters success:(AFHTTPRequestOperationBlockSuccess)success
{
    [self setSuccessBlock:success];
    return [self PUT:URLString parameters:parameters success:self.successBlock failure:self.errorBlock];
}

- (AFHTTPRequestOperation *) DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(AFHTTPRequestOperationBlockSuccess)success
{
    [self setSuccessBlock:success];
    return [self DELETE:URLString parameters:parameters success:self.successBlock failure:self.errorBlock];
}

@end

@implementation AFHTTPRequestOperation (SuccessLog)

- (void) successLog
{
    NSLog(@"------ REQUEST SUCCESS LOG ------");
    NSLog(@"Request %@", [self.request.URL absoluteString]);
    NSLog(@"Status Code %ld", (long)self.response.statusCode);
    NSLog(@"Headers %@", self.response.allHeaderFields);
    NSLog(@"Cookie %@", self.response.allHeaderFields[@"Set-Cookie"]);
    NSLog(@"-------------------------------");
}

@end

@implementation NSDictionary (Succeeded)

- (BOOL) succeeded
{
    return  self && self[@"status"] && [self[@"status"] boolValue];
}

- (BOOL) newUser
{
    return self && self[@"found"] && ![self[@"found"] boolValue];
}

- (NSString *) errorMessage
{
    return self && self[@"error"] ? self[@"error"] : @"";
}

- (void) showError
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention", @"Attention") message:[self errorMessage] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Ok", @"Ok"), nil] show];
    });
}

@end