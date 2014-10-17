//
//  apiclientTests.m
//  apiclientTests
//
//  Created by iBo on 17/10/14.
//  Copyright (c) 2014 iBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Macros.h"
#import "UserClient.h"
#import "UserModel.h"

@interface apiclientTests : XCTestCase {
    UserClient *_userClient;
}

@end

@implementation apiclientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _userClient = [UserClient client];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testParseUser
{
    StartBlock();
    [_userClient getUser:^(AFHTTPRequestOperation *operation, id responseObject) {
        EndBlock();
        if ( [responseObject succeeded] ) {
            UserModel *user = [[UserModel alloc] initWithDictionary:responseObject[@"user"]];
            XCTAssertNotNil(user);
            
            NSLog(@"------------------------------");
            NSLog(@"• %@", user.userId.stringValue);
            NSLog(@"• %@", user.username);
            NSLog(@"• %@", user.name);
            NSLog(@"• %@", user.surname);
            NSLog(@"• %@", user.about);
            NSLog(@"• %@", user.git);
            NSLog(@"------------------------------");
        }
    }];
    
    WaitUntilBlockCompletes();
}

- (void) testError
{
    StartBlock();
    [_userClient getError:^(AFHTTPRequestOperation *operation, id responseObject) {
        EndBlock();
        XCTAssertNotNil(responseObject);
        if ( ![responseObject succeeded] ) {
            NSLog(@"------------------------------");
            NSLog(@"• %@", [responseObject errorMessage] );
            NSLog(@"------------------------------");
        }
    }];
    
    WaitUntilBlockCompletes();
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
