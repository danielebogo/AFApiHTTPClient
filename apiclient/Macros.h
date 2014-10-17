//
//  Macros.h
//  apiclient
//
//  Created by iBo on 17/10/14.
//  Copyright (c) 2014 iBo. All rights reserved.
//

#ifndef apiclient_Macros_h
#define apiclient_Macros_h

// Set the flag for a block completion handler
#define StartBlock() __block BOOL waitingForBlock = YES

// Set the flag to stop the loop
#define EndBlock() waitingForBlock = NO

// Wait and loop until flag is set
#define WaitUntilBlockCompletes() WaitWhile(waitingForBlock)

// Macro - Wait for condition to be NO/false in blocks and asynchronous calls
#define WaitWhile(condition) \
do { \
while(condition) { \
[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]; \
} \
} while(0)

#endif
