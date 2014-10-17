//
//  UserModel.h
//  apiclient
//
//  Created by iBo on 17/10/14.
//  Copyright (c) 2014 iBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface BaseUser : BaseModel
@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *username;
@end

@interface UserModel : BaseUser
@property (nonatomic, copy) NSString *about, *name, *surname, *git;
@end
