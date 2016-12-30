//
//  TRAccountTool.h
//  露露微博
//
//  Created by lushuishasha on 15/8/14.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRAccount.h"

@interface TRAccountTool : NSObject
+(void) saveAccount:(TRAccount *)account;
+ (TRAccount *)returnAccount;
@end
